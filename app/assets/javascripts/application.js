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

function escapeHtml(unsafe) {
    return unsafe
         .replace(/&/g, "&amp;")
         .replace(/</g, "&lt;")
         .replace(/>/g, "&gt;")
         .replace(/"/g, "&quot;")
         .replace(/'/g, "&#039;");
 }
  
function checkMap(){
      $('#question-city').css('top','70px');
      $('#city-input').focus();
      $('#city-input').click();
}

function getUrlParam(name, url) {
  if (!url) url = window.location.href;
  name = name.replace(/[\[\]]/g, "\\$&");
  var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
      results = regex.exec(url);
  if (!results) return null;
  if (!results[2]) return '';
  return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function saveCity(lat,lon,name,url){
  localStorage.setItem("latitude",lat);
  localStorage.setItem("longitude",lon);
  localStorage.setItem("url",url);
  localStorage.setItem("name",name);
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

  $('.actual-city').click(function(){
    $('#city-input').val('');
    $('#city-input').focus();
    $('.mobile-tools').css({'bottom':'-70px'});
    $('.input-search').css({'top':'0px'});
  });

  $('.close-search').click(function(){
    $('.input-search').css({'top':'-70px'});
    $('.mobile-tools').css({'bottom':'0%'});
    
  });

  $('#form-search').submit(function(){
    loadOnMap($('#city-input').val());
    $('.input-search').css({'top':'-100%'});
    $('#city-input').blur();
    if(window.location.pathname.length > 1) {
       window.location="/#";
    }
    return false;
  });

  $(".city-input,.city-input-home").autocomplete({
    source : function(request, response) {
      $.ajax({
        url : "/cidade/search.json?nome="+request.term+"&limit=5",
        dataType : "json",
        success : function(data) {
          response($.map(data, function(item) {
            return {
              label : item.label,
              url   :item.path,
              codigo_ibge: item.codigo_ibge,
              value : item.data
            };
          }));
        }
      });
    },
    minLength : 2,
    select : function(event, ui) {
        console.log(ui.item ? "Selected: " + ui.item.label +" - "+ui.item.codigo_ibge : "Nothing selected, input was " + this.value);
        reclamar = $(this).attr('data-reclamar');
        if(reclamar){
          window.location="/"+ui.item.url+"/reclamar";
        }else{
          window.location="/"+ui.item.url;
        }
    },
    open : function() {
        $(this).removeClass("ui-corner-all").addClass("ui-corner-top");
    },
    close : function() {
        $(this).removeClass("ui-corner-top").addClass("ui-corner-all");
    }
  });


  $('.nav a.hide-nav').on('click',function(){
    $('.navbar-toggle').click() //bootstrap 3.x by Richard
  });


  $('#reclamarSemCidade').click(function(){
    console.log($('.sem-cidade'))
    $('.sem-cidade').focus();
  });
};

$(document).ready(ready);
$(document).on('page:load',ready);
