jQuery ->
  if $('*[data-role="geo-update"][data-id]').length > 0
    $("input[type=submit]").prop("disabled",true)
    $("#loc-status").hide()
    $("#manual-loc").hide()

    $('#getLocation').click -> 
      $("#manual-loc").hide()
      $('#getLocation').button('loading')
      window.GeolocationUpdater = new GeolocationUpdater

    $("#setManualLoc").click ->
      $("#manual-loc").show()
      $("#loc-status").hide()

    geocoder = new google.maps.Geocoder()
    id = $('*[data-id]').data("id")
    $("#useAddress").click ->
      geocoderParams =
        address: $('#address').val() || "Corvallis, Oregon, United States"
      results = geocoder.geocode geocoderParams, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          latlng = results[0].geometry.location
          lat = results[0].geometry.location.lat()
          lng = results[0].geometry.location.lng()
          $.post("/entry/#{id}.json", {civil_entry: {latitude: lat, longitude: lng}, _method: "patch"}, null, 'json')
          $(".loading").hide()
          $("#loc-status").show()
          $("#location").text(results[0].formatted_address)
          $("input[type=submit]").prop("disabled",false)
          # alert(JSON.stringify(results[0].formatted_address))
        else
          alert("not valid")

    $("#setDefaultLoc").click ->
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
    $('#getLocation').button('reset')
    switch err.code
      when err.UNKNOWN_ERROR
        userDeniedLocation # err 0
      when err.PERMISSION_DENIED
        alert("Your location services might be turned off or disabled. Please turn on location services") # err 1
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
