jQuery ->
  if $('*[data-role="geo-update"][data-id]').length > 0
    window.GeolocationUpdater = new GeolocationUpdater

class GeolocationUpdater
  constructor: ->
    return if this.id() == ""
    window.navigator.geolocation.getCurrentPosition(this.updateSerial,null,{enableHighAccuracy: true})
  updateSerial: (data)=>
    coords = data.coords
    $.post("/civil_entries/#{this.id()}.json", {civil_entry: {latitude: coords.latitude, longitude: coords.longitude}, _method: "patch"}, this.updatedSerial)
  updatedSerial: ->
  serial: ->
    @serial_number ||= $('*[data-serial]').data("serial")
  id: ->
    @_id ||= $('*[data-id]').data("id")
