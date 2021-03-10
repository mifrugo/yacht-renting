import mapboxgl from 'mapbox-gl/dist/mapbox-gl.js';
import MapboxGeocoder from 'mapbox-gl-geocoder/dist/mapbox-gl-geocoder.min.js'
import 'mapbox-gl/dist/mapbox-gl.css';
import 'mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css'

let markers = []
var map;

const clearMarkers = () => {
  markers.forEach((marker) => marker.remove());
  markers = [];
};

const setMarker = () => {
  const marker = new mapboxgl.Marker()
    .setLngLat(map.getCenter())
    .addTo(map);

  markers.push(marker);
};

const renderMap = () => {

  console.log('Map init');

  mapboxgl.accessToken = document.querySelector('#map').dataset['apikey']

  map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [document.querySelector('#map').dataset['latitude'], document.querySelector('#map').dataset['longitude']],
    zoom: 12,
    interactive: false
  });

  setMarker();

  document.getElementById('geocoder') && setGeocoder();
};

const setGeocoder = () => {

  console.log('Geocoder init')

  const geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl
  });

  document.getElementById('geocoder').appendChild(geocoder.onAdd(map));

  geocoder.on('result', function (ev) {
    const styleSpec = ev.result;

    document.querySelector('#yacht_lat').value = styleSpec.center[0]
    document.querySelector('#yacht_long').value = styleSpec.center[1]
    document.querySelector('#yacht_address').value = styleSpec.place_name
  });

  map.on('movestart', function () {
    if (document.querySelector('#send-yacht')) {
       document.querySelector('#send-yacht').disabled = true
    }
  })

  map.on('moveend', function (e) {

    clearMarkers();
    setMarker();

    if(document.querySelector('#send-yacht')) {
      document.querySelector('#send-yacht').disabled = false
    }
  });

};


export { renderMap };
