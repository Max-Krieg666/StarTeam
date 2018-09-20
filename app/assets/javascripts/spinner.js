$(document).ready(function() {
  $(".spinner").hide();
  $('a').click(function(e){
    if(!(this.classList.contains("dropdown-toggle"))){
      $(".spinner").show();
    }
  });
  $(document).ajaxStart(function(){
    $(".spinner").show();
  });
  $(document).ajaxStop(function(){
    $(".spinner").hide();
  });
});

