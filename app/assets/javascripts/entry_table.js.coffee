jQuery ->
  window.EntryTableManager = new EntryTableManager

class EntryTableManager
  constructor: ->
    return unless this.element().length > 0
    @dataTable = this.build_table()
    $(".dataTables_length").hide()
  build_table: ->
    this.element().dataTable(order: [[1,"desc"]])
  element: ->
    @civil_table ||= $("#civil_entries table")
