# Datatables
$(document).on 'turbolinks:load', ->
  table = $('#question-sets-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    pageLength: 25
    ajax: $('#question-sets-table').data('source')    
    pagingType: 'full_numbers'
    columns: [
      {data: 'title'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 1 }, { "width": "5%", "targets": 1 },{ className: 'text-center', "targets": 1 }]