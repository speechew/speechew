# Datatables
$(document).on 'turbolinks:load', ->
  table = $('#languages-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    pageLength: 25
    ajax: $('#languages-table').data('source')    
    pagingType: 'full_numbers'
    columns: [
      {data: 'name'}
      {data: 'language_code'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 2 }, { "width": "5%", "targets": 2 },{ className: 'text-center', "targets": 2 }]