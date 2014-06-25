jQuery ->
  if $('*[data-role="geo-update"]')
    window.GeolocationUpdater = new GeolocationUpdater

class GeolocationUpdater
  constructor: ->
    window.navigator.geolocation.getCurrentPosition(this.updateSerial,null,{enableHighAccuracy: true})
  updateSerial: (data)=>
    coords = data.coords
    $.post("/civil_entries/#{this.serial()}.json", {civil_entry: {latitude: coords.latitude, longitude: coords.longitude}, _method: "patch"}, this.updatedSerial)
  updatedSerial: ->
  serial: ->
    @serial_number ||= $('*[data-serial]').data("serial")
