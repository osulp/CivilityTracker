jQuery ->
  if $('*[data-role="geo-update"][data-id]').length > 0
    $("input[type=submit]").prop("disabled",true)
    $("#loc-status").hide()
    $('#getLocation').click -> 
      $('#getLocation').button('loading')
      $("#loc-status").show()
      window.GeolocationUpdater = new GeolocationUpdater
    $("#setDefaultLoc").click ->
      id = $('*[data-id]').data("id")
      defaultLat = 44.573252
      defaultLon = -123.278821
      $.post("/entry/#{id}.json", {civil_entry: {latitude: defaultLat, longitude: defaultLon}, _method: "patch"}, null, 'json')
      $(".loading").hide()
      $("#loc-status").show()
      $("#location").text("Corvallis, Oregon, United States")
      $("input[type=submit]").prop("disabled",false)

 
  
class GeolocationUpdater
  unless navigator.geolocation then alert "Your browser can not support geolocation."
  constructor: ->
    return if this.id() == ""
    window.navigator.geolocation.getCurrentPosition(this.updateSerial,this.onError,{timeout: 30000, enableHighAccuracy: true})
  onError: (err) ->
    switch err.code
      when err.UNKNOWN_ERROR
        userDeniedLocation # err 0
      when err.PERMISSION_DENIED
        alert("Permission Denied - User denied the request for Geolocation - Please turn on location services") # err 1
      when err.POSITION_UNAVAILABLE
        alert("Position Unavailable") # err 2
      when err.TIMEOUT
        alert("Timeout - The request to get user location timed out.") # err 3
      else alert("An unknown error occurred.")
  userDeniedLocation: ->
    alert("An unknown error occurred.")
  updateSerial: (data)=>
    coords = data.coords
    $.post("/entry/#{this.id()}.json", {civil_entry: {latitude: coords.latitude, longitude: coords.longitude}, _method: "patch"}, this.updatedSerial, 'json')
  updatedSerial: (data) ->
    if data.address?
      $("#getLocation").hide()
      $("#loc-status").show()
      $("#location").text(data.address)
      $("input[type=submit]").prop("disabled",false)
      $(".loading").hide()
  serial: ->
    @serial_number ||= $('*[data-serial]').data("serial")
  id: ->
    @_id ||= $('*[data-id]').data("id")
