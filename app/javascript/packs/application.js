// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
// import "bootstrap"
// import "../stylesheets/application"

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("bootstrap")
require("jquery")
require("@nathanvda/cocoon")

var jQuery = require("jquery");
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

require('jquery-ui');
// jquery-ui theme
require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.css/ );
require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.theme\.css/ );
