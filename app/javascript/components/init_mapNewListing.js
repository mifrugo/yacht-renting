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

const formatHTML = (k, val) => {
  let html = `<h5 class="text-center">Yachts in ${k}</h5><ul class="mb-0 px-3">`

  val.forEach((v) => {
    html += `<li><a href="/yachts/${v.id}">${v.title}</a></li>`
  })

  html += '</ul>'

  return html
};

const setMarker = () => {

  if (document.querySelector('#map').dataset['markers'])
  {
    const markers = JSON.parse(document.querySelector('#map').dataset['markers']);

    for (let [key, value] of Object.entries(markers)) {

      const popup = new mapboxgl.Popup({ offset: 25 }).setHTML(formatHTML(key, value));

      let el = document.createElement('div');
      el.id = 'marker';

      new mapboxgl.Marker(el)
        .setLngLat([value[0].lat, value[0].long])
        .setPopup(popup)
        .addTo(map);
    }

  } else {
    const marker = new mapboxgl.Marker()
      .setLngLat(map.getCenter())
      .addTo(map);

    markers.push(marker);
  }
};

const renderMap = () => {

  console.log('Map init');

  mapboxgl.accessToken = document.querySelector('#map').dataset['apikey']
  const zoom = document.querySelector('#map').dataset['zoom'] ? document.querySelector('#map').dataset['zoom'] : 12;

  map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v11',
    center: [document.querySelector('#map').dataset['latitude'], document.querySelector('#map').dataset['longitude']],
    zoom: zoom,
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

    clearMarkers();
    setMarker();
    console.log('Updating ...')

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
    if(document.querySelector('#send-yacht')) {
      document.querySelector('#send-yacht').disabled = false
    }
  });

};


export { renderMap };
