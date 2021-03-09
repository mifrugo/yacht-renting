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
import { blockDropDown } from '../components/init_blockdropdown'
import { renderMap } from '../components/init_mapNewListing'

import 'bootstrap-select/dist/js/bootstrap-select.min.js';

document.addEventListener('turbolinks:load', () => {
  removeAlert();
  blockDropDown();

  (document.body.classList.contains('yachts-new') || document.body.classList.contains('yachts-edit')) && renderMap();
});
