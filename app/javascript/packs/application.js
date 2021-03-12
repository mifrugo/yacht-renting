// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap";

import $ from "jquery";
window.$ = $;

import { removeAlert } from '../components/init_removeAlert'
import { renderMap } from '../components/init_mapNewListing'
import { initTimeAgo } from '../components/init_timeago'
import { navBar } from '../components/init_navbar'

import 'bootstrap-select/dist/js/bootstrap-select.min.js';

document.addEventListener('turbolinks:load', () => {
  document.querySelector('#map') && renderMap();

  removeAlert();
  initTimeAgo();

  navBar();

  $('.selectpicker').selectpicker();

});
