# Datatables
$(document).on 'turbolinks:load', ->
  table = $('#countries-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    pageLength: 25
    ajax: $('#countries-table').data('source')    
    pagingType: 'full_numbers'
    columns: [
      {data: 'name'}
      {data: 'country_code'}
      {data: 'continent_name'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 3 }, { "width": "5%", "targets": 3 },{ className: 'text-center', "targets": 3 }]