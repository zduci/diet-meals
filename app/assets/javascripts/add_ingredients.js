function make_id_unique(content){
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_ingredient", "g");
  content.replace(regexp, new_id);
  return content;
}
function add_ingredient(link){
  link.before(make_id_unique(ingredient_attributes));
}
jQuery(document).ready(function() { 
  $('#add_ingredient').click(function() {
    add_ingredient($(this));
    bind_remove_buttons($(this));
  }) 
})

