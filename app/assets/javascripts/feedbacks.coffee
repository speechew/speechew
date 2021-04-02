# Datatables
$(document).on 'turbolinks:load', ->
  table = $('#feedbacks-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    pageLength: 25
    ajax: $('#feedbacks-table').data('source')    
    pagingType: 'full_numbers'
    columns: [
      {data: 'fluency'}
      {data: 'vocabulary'}
      {data: 'grammar'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 3 }, { "width": "5%", "targets": 3 },{ className: 'text-center', "targets": 3 }]