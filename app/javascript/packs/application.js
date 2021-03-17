/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../../assets/images', true)
function imagePath(name) {
  images(name, true)
}

// To use actioncable, see example bellow
// import '../channels/example_channel.js'

import Rails from "@rails/ujs"
window.Rails = Rails;
import * as ActiveStorage from "@rails/activestorage"
import jstz from'jstz'
window.jstz = jstz
import $ from 'jquery';
window.jQuery = $;
window.$ = $;
import 'bootstrap';
import 'material-design-iconic-font/dist/css/material-design-iconic-font.css';
import 'autosize'
import 'select2'
import 'sweetalert2'
import 'lightbox2'

import '../theme/js/functions/app'
import '../theme/js/functions/vendors'
import '../theme/js/functions/custom-inputmasks'
import '../theme/js/functions/file-input'
import '../theme/js/functions/full-calendar'
import '../theme/js/functions/active-storage-direct-upload'
import '../theme/js/actions'
import '../theme/js/functions/swal-ujs'

Rails.start()
ActiveStorage.start()

console.log('Hello World from Webpacker5')
