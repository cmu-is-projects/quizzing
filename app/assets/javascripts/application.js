// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery_nested_form
//= require turbolinks
//= require materialize-sprockets
//= require best_in_place
//= require_tree .

//from datatables
// $(document).ready( function () {
//     $('#table_id').DataTable();
// } );

// Datepicker code
$(function() {
	$(".datepicker").datepicker({
		format: 'mm/dd/YYYY'
	});
});

$(document).ready(function() {
  /* Activating Best In Place */
    jQuery(".best_in_place").best_in_place();
});

//Toggle Search bar
$("#toggle-search").click(function(){
	 event.preventDefault();
    $("#search-bar").toggle();
});