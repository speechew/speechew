// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require fontawesome-free/js/all.min.js
//= require bootstrap/js/bootstrap.bundle.js
//= require jquery-easing/jquery.easing.js
//= require js/sb-admin-2.js
//= require select2
//= require cocoon
//= require datatables/jquery.dataTables.min.js
//= require datatables/dataTables.bootstrap4.min.js
//= require activestorage
//= require turbolinks
//= require_tree .
(function() {

  $(document).on('turbolinks:load', function() {
    var i, table, tableElementId, tableElementIds;
    tableElementIds = ['#topics-table', '#pages-table', '#knowledge-books-table', '#tags-table', '#religions-table', '#users-table', '#religions-table', '#languages-table', '#question-sets-table', '#countries-table', '#categories-table','#articles-table'];
    i = 0;
    while (i < tableElementIds.length) {
      tableElementId = tableElementIds[i];
      if ($.isEmptyObject($.find(tableElementId))) {
        i++;
        continue;
      }
      table = void 0;
      if ($.fn.DataTable.isDataTable(tableElementId)) {
        table = $(tableElementId).DataTable();
      } else {
        table = $(tableElementId).DataTable();
      }
      document.addEventListener('turbolinks:before-cache', function() {
        table.destroy();
      });
      i++;
    }

    $("#start-call-btn").click(function(){

      navigator.getUserMedia = navigator.getUserMedia ||
      navigator.webkitGetUserMedia ||
      navigator.mozGetUserMedia;

      if (navigator.getUserMedia) {
        navigator.getUserMedia({ audio: true, video: true },
          function(stream) {
           $.get("/start_speaking");
         },
         function(err) {
           if(err.name == "NotAllowedError"){
            alert("You need to allow acceess to your web cam and microphone.");
          }
        });
      } else {
       console.log("getUserMedia not supported");
     }
   });
    $(document).on('click', '.toggle-window', function(e) {
      e.preventDefault();
      var panel = $(this).parent().parent();
      var messages_list = panel.find('.messages-list');

      panel.find('.panel-body').toggle();
      panel.attr('class', 'panel panel-default');

      if (panel.find('.panel-body').is(':visible')) {
        var height = messages_list[0].scrollHeight;
        messages_list.scrollTop(height);
      }
    });
    var timer2 = "5:01";
    function start_timer(){
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
    $('.countdown').html(minutes + ':' + seconds);
    timer2 = minutes + ':' + seconds;
  }, 1000);
    }
  });

}).call(this);