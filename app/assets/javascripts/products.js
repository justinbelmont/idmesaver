$(document).ready(function(){

 $(function(){ 
  $(".mens").hide();
  $(".womens").hide();
 });

 $("#mennav").children("img").click(function(){
   $(".womens").hide();
   $(".mens").toggle(1000);
 });


 $("#womennav").children("img").click(function(){
   $(".mens").hide();
   $(".womens").toggle(1000);
 });
 
});