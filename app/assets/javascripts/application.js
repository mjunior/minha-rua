// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require jquery-ui
//= require markerclusterer.min
//= require social-share-button
//= require_tree .


  function checkMap(){
      if(!localStorage.latitude && !localStorage.longitude){
          $('#question-city').css('top','0%')
      }else{
          var latitude = localStorage.latitude
          var longitude = localStorage.longitude
          var location = new google.maps.LatLng(latitude, longitude);
          map.setCenter(location);
          map.setZoom(14)
      }
  }

function FormatForUrl(str) {
    return str.replace(/_/g, '-')
        .replace(/ /g, '-')
        .replace(/:/g, '-')
        .replace(/\\/g, '-')
        .replace(/\//g, '-')
        .replace(/[^a-zA-Z0-9\-]+/g, '')
        .replace(/-{2,}/g, '-')
        .toLowerCase();
};


var ready;
ready = function() {

  $('#search-mobile').click(function(){
    $('#city-input-mobile').val('');
    $('#city-input-mobile').focus();
    $('.input-search-mobile').css({'bottom':'60px'});
  })

  $('#form-searc-mobile').submit(function(){
    loadOnMap($('#city-input-mobile').val());
    $('.input-search-mobile').css({'bottom':'100%'});
    $('#city-input-mobile').blur();
    if(window.location.pathname.length > 1) {
       window.location="/#";
    }
    return false;
  })

  $('.nav a').on('click', function(){
    $('.navbar-toggle').click() //bootstrap 3.x by Richard
  });

  /*Carrega todas as cidades Brasileiras */
  var cities = []
  $.get('/json/brazil-cities-states.json').success(function(data){
    console.log('cities')
      $.each(data.estados,function(i,value){
        var sigla = value.sigla;
        $.each(value.cidades,function(k,val){
          cities.push(val+" - "+sigla)
        })
      });


      $( "#city-input" ).autocomplete({
        source: cities,
        appendTo: "#home-big",
        select:function(event,ui){
          $('#city-input').blur();
          loadOnMap(ui.item.value);
        }
      });

      $( "#city-input-nav" ).autocomplete({
        source: cities,
        appendTo: "#home",
        select:function(event,ui){
          loadOnMap(ui.item.value);
          console.log(window.location.pathname);
          if(window.location.pathname.length > 1) {
             window.location="/#";
          }
        }
      });

      $( "#city-input-mobile" ).autocomplete({
        source: cities,
        appendTo: "#home",
        select:function(event,ui){
          loadOnMap(ui.item.value);
          $('.input-search-mobile').css({'bottom':'100%'});
          $('#city-input-mobile').blur();
          if(window.location.pathname.length > 1) {
             window.location="/#";
          }
        }
      });
  })
};

$(document).ready(ready);
$(document).on('page:load', ready);
