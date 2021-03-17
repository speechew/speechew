# Datatables
$ ->
  table = $('#<%= plural_table_name.dasherize.downcase %>-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    ajax: $('#<%= plural_table_name.dasherize.downcase %>-table').data('source')    
    pagingType: 'full_numbers'
    columnDefs: [{ "orderable": false, "targets": 1 }]
