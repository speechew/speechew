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
      {data: 'categories'}
      {data: 'status'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 3 }, { "width": "5%", "targets": 3 },{ className: 'text-center', "targets": 3 }]

  all_table = $('#admin-articles-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    pageLength: 25
    ajax: $('#admin-articles-table').data('source')    
    pagingType: 'full_numbers'
    columns: [
      {data: 'title'}
      {data: 'categories'}
      {data: 'editor'}
      {data: 'status'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 4 }, { "width": "5%", "targets": 4 },{ className: 'text-center', "targets": 4 }]