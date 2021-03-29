# Datatables
$(document).on 'turbolinks:load', ->
  table = $('#users-table').dataTable
    dom: 'C<"clear">lfrtip'
    processing: true
    serverSide: true
    pageLength: 25
    ajax: $('#users-table').data('source')    
    pagingType: 'full_numbers'
    columns: [
      {data: 'name'}
      {data: 'email'}
      {data: 'sign_in_count'}
      {data: 'current_sign_in_at'}
      {data: 'ops'}
    ]
    columnDefs: [{ "orderable": false, "targets": 4 }, { "width": "5%", "targets": 4 },{ className: 'text-center', "targets": 4 }]

