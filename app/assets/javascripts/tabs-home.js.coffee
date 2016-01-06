jQuery ->
  $("#myTabs a").click (event)->
    event.preventDefault()
    $(this).tab('show')


