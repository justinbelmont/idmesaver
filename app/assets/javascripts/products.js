$(document).ready(function(){

$(function(){ 
  $(".mens").hide();
  $(".womens").hide();
});

 $(".mennav").children("button").click(function(){
   $(".mens").toggle(1000);
 });


 $(".womennav").children("button").click(function(){
   $(".womens").toggle(1000);
 });
});