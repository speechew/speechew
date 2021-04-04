import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
  	if(data['message'] == "no_users_online"){
  		alert("No users online. Try again after some time.");
  	}else if(data['message'] == "incoming_call"){
  	  $("#calling-modal").modal("show");
  	  $("#call-reject").trigger('click');
  	}else if(data['message'] == "all_users_busy"){
  	  alert("All users busy. Try again after some time.");

  	  window.onbeforeunload = null;
  	  $("#speak-now-outer").html("");
  	  $("#start-speaking-btn").show();
      $("#stop-video-btn").hide();
      $("#speak-now-outer").html("<h4>Press the start session button to start practicing english speaking</h4>");
  	}
  	
    // Called when there's incoming data on the websocket for this channel
  }
});
