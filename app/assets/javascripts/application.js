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
//= require datatables/jquery.dataTables.min.js
//= require datatables/dataTables.bootstrap4.min.js
//= require activestorage
//= require turbolinks
//= require_tree .
(function() {
  $(document).on('turbolinks:load', function() {
    var i, table, tableElementId, tableElementIds;
    tableElementIds = ['#tasks-table', '#user-roles-table', '#base-names-table', '#tags-table', '#religions-table', '#users-table', '#religions-table', '#languages-table', '#families-table', '#countries-table', '#categories-table'];
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
  });

}).call(this);