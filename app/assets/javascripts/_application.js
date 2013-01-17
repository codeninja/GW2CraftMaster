jQuery(document).ready(function($) {
	
// Select nav for smaller resolutions
// Select menu for smaller screens
$("<select />").appendTo("nav#primary");

// Create default option "Menu"
$("<option />", {
   "selected": "selected",
   "value"   : "",
   "text"    : "Menu"
}).appendTo("nav#primary select");

// Populate dropdown with menu items
$("nav#primary a").each(function() {
 var el = $(this);
 $("<option />", {
     "value"   : el.attr("href"),
     "text"    : el.text()
 }).appendTo("nav select");
});

$("nav#primary select").change(function() {
  window.location = $(this).find("option:selected").val();
});

// Pretty Photo
$("a[class^='prettyPhoto']").prettyPhoto();

// Tipsy
$('.tooltip').tipsy({
	gravity: $.fn.tipsy.autoNS,
	fade: true,
	html: true
});

$('.tooltip-s').tipsy({
	gravity: 's',
	fade: true,
	html: true
});

$('.tooltip-e').tipsy({
	gravity: 'e',
	fade: true,
	html: true
});

$('.tooltip-w').tipsy({
	gravity: 'w',
	fade: true,
	html: true
});

// Scroll
jQuery.localScroll();

// Prettyprint
$('pre').addClass('prettyprint linenums');

// Uniform
// , input:checkbox, input:radio, input:file
$("select").uniform();

$(".list_select_all").click(function(e){
	boxes = $(this).parents("table").find("input.craft_selection_checkbox	")
	boxes.prop('checked', $(this).prop("checked")).change()
})

$("input.craft_selection_checkbox").change(function(){
	items_input = $("#selected_items")
	values = $("input:checkbox:checked.craft_selection_checkbox").map(function(){return this.value}).get()
	items_input.val(values)
	
})


$("input.onhand").change(function(){
	value = $(this).val();
	need_cell = $(this).parent().siblings('.needed')
	
	if($.isNumeric(value)){
		if(value >0){
			need_cell.html(need_cell.data("base") - value)
		}else{
			need_cell.html( need_cell.data("base"))
		}
	}else{
		$(this).val(0)
		need_cell.html( need_cell.data("base"))		
	}	
})

// 	END READY
});


