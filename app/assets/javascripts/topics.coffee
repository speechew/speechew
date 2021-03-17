# Datatables
$(document).on 'turbolinks:load', ->
  table = $('#topics-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    pageLength: 25
    ajax: $('#topics-table').data('source')    
    pagingType: 'full_numbers'
    columns: [
      {data: 'name'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 1 }, { "width": "5%", "targets": 1 },{ className: 'text-center', "targets": 1 }]