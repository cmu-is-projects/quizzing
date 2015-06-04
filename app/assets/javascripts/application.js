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
//= require materialize-sprockets
//= require best_in_place
//= require_tree .
//= require highcharts/highstock
//= require highcharts/highcharts                                                           
//= require highcharts/highcharts-more

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
    $(".button-collapse").sideNav();
});


$(document).ready(function() {
    $('#toggle-search').click(function() {
            $('#search-bar').slideToggle("slow");
    });
});


$(document).ready(function () {
        var url = window.location;
        $('.side-nav.fixed li').find('.active').removeClass('active');
        $('.side-nav.fixed li a').each(function () {
            if ( this.pathname != "/home" && this.href == url) {
                $(this).parent().addClass('active');
            }
        }); 
    });


  $(document).ready(function(){
    $('ul.tabs').tabs();
  });

$(document).ready(function(){
      $('.slider').slider({full_width: false});
    });

$(document).ready(function() {
    $('.present-icon').click(function(event){
      event.preventDefault();
      var icon = $('#present-icon');
      if(icon.hasClass('mdi-toggle-check-box')){
        icon.removeClass('mdi-toggle-check-box ');
        icon.addClass('mdi-navigation-cancel');
      }
      else {
        icon.removeClass('mdi-navigation-cancel');
        icon.addClass('mdi-toggle-check-box');
      }
    });
});


