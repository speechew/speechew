import { Controller} from "stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  static targets = ["remote_videos", "local_video"]

  connect() {
    $("#start-speaking-btn").hide();
    $("#stop-video-btn").show();
      window.onbeforeunload = function() {
  return "Data will be lost if you leave the page, are you sure?";
};
    this.currentUser = this.data.get("session")
    this.pcPeers = {}
    this.ice = {
      "iceServers": [
      {
        urls: 'turn:turn.vaas.me',
        credential: 'driftingruby',
        username: 'driftingruby'
      },
      ]
    }
    this.JOIN_ROOM = "JOIN_ROOM"
    this.EXCHANGE = "EXCHANGE"
    this.REMOVE_USER = "REMOVE_USER"
    this.stream().then(stream => {
      this._stream = stream
      this.local_videoTarget.srcObject = stream
      this.local_videoTarget.muted = true
    }).then(() => {
      this.subscription()
    })
  }

  disconnect() {
    this.subscription().unsubscribe()
    this.subscription().disconnected()
    this.stream().getTracks().forEach( function (track) {
      track.stop()
    })
  }

  stream() {
    if (this._stream == undefined) {
      return navigator.mediaDevices.getUserMedia({ audio: true, video: true })
    }
    return this._stream
  }

  subscription() {
    if (this._subscription == undefined) {

      let _this = this
      this._subscription = consumer.subscriptions.create({ channel: "RoomChannel", id: _this.data.get("id") }, {
        connected() {
          this.send({ type: _this.JOIN_ROOM, from: _this.currentUser })
        },
        disconnected() {
          this.send({ type: _this.REMOVE_USER, from: _this.currentUser })
        },
        received(data) {
          if (data.from === _this.currentUser) return
            switch (data.type) {
              case _this.JOIN_ROOM:
              return _this.joinRoom(data)
              case _this.EXCHANGE:
              $(".loading-user").remove();
              var timer2 = "5:01";
              var interval = setInterval(function() {


                var timer = timer2.split(':');
                //by parsing integer, I avoid all extra string processing
                var minutes = parseInt(timer[0], 10);
                var seconds = parseInt(timer[1], 10);
                --seconds;
                minutes = (seconds < 0) ? --minutes : minutes;
                if (minutes < 0) clearInterval(interval);
                seconds = (seconds < 0) ? 59 : seconds;
                seconds = (seconds < 10) ? '0' + seconds : seconds;
                //minutes = (minutes < 10) ?  minutes : minutes;
                $('#speaking-status').html(minutes + ':' + seconds);
                timer2 = minutes + ':' + seconds;
              }, 1000);
              if (data.to !== _this.currentUser) return
                return _this.exchange(data)
              case _this.REMOVE_USER:
              return _this.removeUser(data)
              default:
              return
            }
          },
        })
    }
    return this._subscription
  }

  joinRoom(data) {
    this.createPC(data.from, true)
  }

  exchange(data) {
    let pc
    if (!this.pcPeers[data.from]) {
      pc = this.createPC(data.from, false)
    } else {
      pc = this.pcPeers[data.from]
    }

    if (data.candidate) {
      pc.addIceCandidate(new RTCIceCandidate(JSON.parse(data.candidate)))
    }

    if (data.sdp) {
      const sdp = JSON.parse(data.sdp)
      let _this = this
      pc.setRemoteDescription(new RTCSessionDescription(sdp))
      .then(() => {
        if (sdp.type === "offer") {
          pc.createAnswer()
          .then((answer) => {
            return pc.setLocalDescription(answer)
          })
          .then(() => {
            _this.subscription().send({
              type: _this.EXCHANGE,
              from: _this.currentUser,
              to: data.from,
              sdp: JSON.stringify(pc.localDescription)
            })
          })
        }
      })
    }
  }

  removeUser(data) {
    window.onbeforeunload = null;
    $("#speak-now-outer").html("");
    $("#speak-now-outer").html("<h4>Your session completed.You will be redirected to give feedback page shortly.</h4>");
    $.get("/end-session");
    
    let video = document.getElementById(`remoteVideoContainer+${data.from}`)
    video && video.remove()
    delete this.pcPeers[data.from]
  }

  createPC(userId, isOffer) {
    let pc = new RTCPeerConnection(this.ice)
    this.pcPeers[userId] = pc
    let _this = this
    for (const track of _this.stream().getTracks()) {
      pc.addTrack(track, _this.stream())
    }

    isOffer && pc
    .createOffer()
    .then((offer) => {
      return pc.setLocalDescription(offer)
    })
    .then(() => {
      _this.subscription().send({
        type: _this.EXCHANGE,
        from: _this.currentUser,
        to: userId,
        sdp: JSON.stringify(pc.localDescription)
      })
    })

    pc.onicecandidate = (event) => {
      event.candidate &&
      _this.subscription().send({
        type: _this.EXCHANGE,
        from: _this.currentUser,
        to: userId,
        candidate: JSON.stringify(event.candidate)
      })
    }

    pc.ontrack = (event) => {
      let id = `remoteVideoContainer+${userId}`
      if (document.getElementById(id) !== null) return
        const element = document.createElement("video")
      element.id = id
      element.autoplay = "autoplay"
      element.srcObject = event.streams[0]
      _this.remote_videosTarget.appendChild(element)
    }

    pc.oniceconnectionstatechange = () => {
      if (pc.iceConnectionState == "disconnected") {
        _this.subscription().send({
          type: _this.REMOVE_USER,
          from: userId
        })
      }
    }

    return pc
  }
}