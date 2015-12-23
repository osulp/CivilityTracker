jQuery ->
  window.MapManager = new MapManager 
class MapManager
  constructor: ->
    return unless this.mapElement()?
    @map = new google.maps.Map(this.mapElement(), this.options())
    $.getJSON('/entry.json', this.createMarkers)
  createMarkers: (data) =>
    if data.length > 0 # create markers if one or more datapoints
      @markers ||= []
      @latlngs ||= []
      @infowindows ||= []
      for entry in data
        date = new Date(entry.created_at)
        normalizedDate = new Date(date - (date.getTimezoneOffset() * 60 * 1000))
        infowindow = new google.maps.InfoWindow({
          content: "#{entry.reason} recorded on #{normalizedDate.toISOString().split("T")[0]}"
        })
        latlng = new google.maps.LatLng(entry.latitude, entry.longitude)
        marker = new google.maps.Marker({
          position: latlng
          map: @map
          title: "#{entry.reason}"
        })
        @markers.push marker
        @infowindows.push infowindow
        @latlngs.push latlng

      bounds = new google.maps.LatLngBounds()
      for latlng in @latlngs
        bounds.extend(latlng)
      @map.setCenter(bounds.getCenter())
      @map.fitBounds(bounds)

      index = 0

      for marker in @markers
        the_window = @infowindows[index]
        map = @map
        index = index + 1
        `google.maps.event.addListener(marker,'click', (function(marker,the_window){
           return function() {
             the_window.open(map, marker);
           };
        })(marker,the_window))`
  mapElement: ->
    @map_element ||= document.getElementById("civil-map")
  options: ->
    {
      center: this.center()
      zoom: this.zoom()
    }
  center: ->
    new google.maps.LatLng(44.5651979,-123.2751336)
  zoom: ->
    12
