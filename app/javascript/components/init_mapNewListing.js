import mapboxgl from 'mapbox-gl/dist/mapbox-gl.js';
import MapboxGeocoder from 'mapbox-gl-geocoder/dist/mapbox-gl-geocoder.min.js'

const renderMap = () => {
  mapboxgl.accessToken = 'pk.eyJ1IjoibWlmcnVnbyIsImEiOiJja2xjNHIxMHcwNHN5MnVtcGd5YnVnYm1uIn0.V2sujzsdEYYAvWGKQ-ZwQA';
  var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [12.496365, 41.902782],
    zoom: 12
  });


  var geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl
  });

  document.getElementById('geocoder').appendChild(geocoder.onAdd(map));

  map.on('moveend', function (e) {
    const { lng, lat } = map.getCenter();
    document.querySelector('#yacht_lat').value = lat
    document.querySelector('#yacht_long').value = lng
  });
};

export { renderMap };
