window.addEventListener('unload', function() {
  $(".spinner").hide();
});

$(document).ready(function() {
  $(".spinner").hide();
  $('a').click(function(e){
    if(!(this.classList.contains("dropdown-toggle") ||
      this.classList.contains("no-spinner"))
    ){
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
