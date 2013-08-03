jQuery(document).ready(bind_remove_buttons);

function bind_remove_buttons() { 
  $('.remove_ingredient').click(function() { $(this).closest('.ingredient').remove(); }) 
}
