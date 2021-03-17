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
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// console.log('Hello World from Webpacker')
// Support component names relative to this directory:
var componentRequireContext = require.context("public", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);

// console.log("%cBuilt by %cRDM%cA%cPPS ", "display: block;font-weight: bold;font-size:1rem;", "font-weight: bold;font-size:2.5rem;color:#d53161", "font-weight: bold;font-size:2.5rem;color:white", "font-weight: bold;font-size:2.5rem;color:#d53161");