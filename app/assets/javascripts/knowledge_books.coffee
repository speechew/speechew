# Datatables
$(document).on 'turbolinks:load', ->
  table = $('#knowledge-books-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    pageLength: 25
    ajax: $('#knowledge-books-table').data('source')    
    pagingType: 'full_numbers'
    columns: [
      {data: 'code'}
      {data: 'title'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 2 }, { "width": "5%", "targets": 2 },{ className: 'text-center', "targets": 2 }]