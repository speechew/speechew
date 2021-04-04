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
//= require js/jquery.undoCountdown.js
//= require activestorage
//= require turbolinks
//= require_tree .

(function() {

  $(document).on('turbolinks:load', function() {
    var i, table, tableElementId, tableElementIds;
    tableElementIds = ['#topics-table', '#pages-table', '#knowledge-books-table', '#tags-table', '#religions-table', '#users-table', '#religions-table', '#languages-table', '#question-sets-table', '#countries-table', '#categories-table','#articles-table', '#feedbacks-table'];
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

    

    $('#stop-video-btn').click(function() {
      window.onbeforeunload = null;
      $("#speak-now-outer").html("");
    $("#speak-now-outer").html("<h4>Your session completed.You will be redirected to give feedback page shortly.</h4>");
    
    $.get("/end-session");
    });

  $("#call-accept").click(function(){
    window.location = "/speak-now?call=true";
  });
  // $("#call-reject").click(function(){
  //   $.get("/decline-call");
  //   $("#calling-modal").modal("hide");
  // });
  $("#call-reject").undoCountdown({
  seconds: 10,
  term:'Decline',
  url: "/decline-call",
  onComplete: function() {
    if ($('#calling-modal').is(':visible')) {
      $.get("/decline-call");
    $("#calling-modal").modal("hide");
    }
    
  }
});
});
}).call(this); 