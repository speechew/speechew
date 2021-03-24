# Datatables
$(document).on 'turbolinks:load', ->
  table = $('#articles-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    pageLength: 25
    ajax: $('#articles-table').data('source')    
    pagingType: 'full_numbers'
    columns: [
      {data: 'title'}
      {data: 'status'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 2 }, { "width": "5%", "targets": 2 },{ className: 'text-center', "targets": 2 }]