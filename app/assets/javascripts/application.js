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

$(document).ready(function(){
  $('.nav a').on('click', function(){
      $('.navbar-toggle').click() //bootstrap 3.x by Richard
  });
})

function checkMap(){
  	if(localStorage.latitude && localStorage.longitude){
        $('#question-city').css('top','100%')
        var latitude = localStorage.latitude
        var longitude = localStorage.longitude
        var location = new google.maps.LatLng(latitude, longitude);
        map.setCenter(location);
        map.setZoom(14)
        console.log(map)
    }

    
}

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
          console.log(ui)
          console.log(ui.item.value)
          loadOnMap(ui.item.value);
        }
      });

      $( "#city-input-nav" ).autocomplete({
        source: cities,
        appendTo: "#home",
        select:function(event,ui){
          console.log(ui)
          console.log(ui.item.value)
          loadOnMap(ui.item.value);
        }
      });
  })