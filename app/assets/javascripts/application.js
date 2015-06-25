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
//= require highcharts/highstock
//= require highcharts/highcharts                                                           
//= require highcharts/highcharts-more
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


$('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15 // Creates a dropdown of 15 years to control year
  });

// binding for best in place
$(document).ready(function() {
  /* Activating Best in Place */
  jQuery(".best_in_place").best_in_place()
});



$(document).ready(function() {
  $('tr.more-top-students').hide();
  $('a.more-top-students').click(function(event) {
    event.preventDefault();
    $('tr.more-top-students').fadeToggle('fast', function() {
      if( $('tr.more-top-students').is(':visible') ) {
       $('a.more-top-students').html('Less <i class="fa fa-angle-double-up"></i>')
     }
     else {
       $('a.more-top-students').html('More <i class="fa fa-angle-double-down"></i>')
     }           
   });
    
  });
});

$(document).ready(function() {
  $('tr.more-improved-students').hide();
  $('a.more-improved-students').click(function(event) {
    event.preventDefault();
    $('tr.more-improved-students').fadeToggle('fast', function() {
      if( $('tr.more-improved-students').is(':visible') ) {
       $('a.more-improved-students').html('Less <i class="fa fa-angle-double-up"></i>')
     }
     else {
       $('a.more-improved-students').html('More <i class="fa fa-angle-double-down"></i>')
     }           
   });
    
  });
});

//area admin dashboard 'more'/'less' functionality

$(document).ready(function() {
  $('tr.more-organizations').hide();
  $('tr.more-coaches').hide();
  $('tr.more-students').hide();
  $('tr.more-teams').hide();
});


$(document).on('click', 'a.more-organizations', function(event) {
  event.preventDefault();
  $('tr.more-organizations').fadeToggle('fast', function() {
    if( $('tr.more-organizations').is(':visible') ) {
     $('a.more-organizations').html('Less <i class="fa fa-angle-double-up"></i>')
   }
   else {
     $('a.more-organizations').html('More <i class="fa fa-angle-double-down"></i>')
   }           
 });
});

$(document).on('click','a.more-coaches', function(event) {
  event.preventDefault();
  $('tr.more-coaches').fadeToggle('fast', function() {
    if( $('tr.more-coaches').is(':visible') ) {
     $('a.more-coaches').html('Less <i class="fa fa-angle-double-up"></i>')
   }
   else {
     $('a.more-coaches').html('More <i class="fa fa-angle-double-down"></i>')
   }           
 });
});

$(document).on('click','a.more-students',function(event) {
  event.preventDefault();
  $('tr.more-students').fadeToggle('fast', function() {
    if( $('tr.more-students').is(':visible') ) {
     $('a.more-students').html('Less <i class="fa fa-angle-double-up"></i>')
   }
   else {
     $('a.more-students').html('More <i class="fa fa-angle-double-down"></i>')
   }           
 });
});

$(document).on('click', "a.more-teams", function( event ) {
  event.preventDefault();
  $('tr.more-teams').fadeToggle('fast', function() {
    if( $('tr.more-teams').is(':visible') ) {
     $('a.more-teams').html('Less <i class="fa fa-angle-double-up"></i>')
   }
   else {
     $('a.more-teams').html('More <i class="fa fa-angle-double-down"></i>')
   }           
 }); 
});

var orgVisible;
var coachVisible;
var studentVisible;
var teamVisible;


$(document).ajaxStart(function(){
    if( $('tr.more-organizations').is(':visible')){ 
      orgVisible = true;
    }
    else {
      orgVisible = false;
    }
}).ajaxStop(function(){
    if(orgVisible == true){
      $('tr.more-organizations').show()
      $('a.more-organizations').html('Less <i class="fa fa-angle-double-up"></i>')
    }
    else{
      $('tr.more-organizations').hide()
      $('a.more-organizations').html('More <i class="fa fa-angle-double-down"></i>')
    }
});

$(document).ajaxStart(function(){
    if( $('tr.more-coaches').is(':visible')){ 
      coachVisible = true;
    }
    else {
      coachVisible = false;
    }
}).ajaxStop(function(){
    if(coachVisible == true){
      $('tr.more-coaches').show()
      $('a.more-coaches').html('Less <i class="fa fa-angle-double-up"></i>')
    }
    else{
      $('tr.more-coaches').hide()
      $('a.more-coaches').html('More <i class="fa fa-angle-double-down"></i>')
    }
});

$(document).ajaxStart(function(){
    if( $('tr.more-students').is(':visible')){ 
      studentVisible = true;
    }
    else {
      studentVisible = false;
    }
}).ajaxStop(function(){
    if(studentVisible == true){
      $('tr.more-students').show()
      $('a.more-students').html('Less <i class="fa fa-angle-double-up"></i>')
    }
    else{
      $('tr.more-students').hide()
      $('a.more-students').html('More <i class="fa fa-angle-double-down"></i>')
    }
});


$(document).ajaxStart(function(){
    if( $('tr.more-teams').is(':visible')){ 
      teamVisible = true;
    }
    else {
      teamVisible = false;
    }
}).ajaxStop(function(){
    if(teamVisible == true){
      $('tr.more-teams').show()
      $('a.more-teams').html('Less <i class="fa fa-angle-double-up"></i>')
    }
    else{
      $('tr.more-teams').hide()
      $('a.more-teams').html('More <i class="fa fa-angle-double-down"></i>')
    }
});

$(document).ready(function() {
  $('select').material_select();
});

$(document).ready(function() {
  $('select#team_switch').change(function(){
    $(this).closest("form").submit();
  });
});

$(document).ready(function() {
  $('select#division_switch').change(function(){
    $(this).closest("form").submit();
  });
});

