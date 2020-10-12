//= require jquery
//= require jquery.tablesorter.min
//= require bootstrap
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  if($('table').length > 0){
    $('table').tablesorter();
  }
});