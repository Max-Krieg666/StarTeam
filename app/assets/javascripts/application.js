//= require jquery
//= require jquery.tablesorter.min
//= require bootstrap-select
//= require bootstrap-sprockets
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
	if($('table').length > 0){
    $('table').tablesorter();
	}
});