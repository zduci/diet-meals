jQuery(document).ready(function() { 
  function invalid(selector){
    element = $(selector);
    if (!$.trim(element.val())){
      element.popover('show');
      return true;
    } else {
      return false;
    }
  }
  $('#new_meal').submit(function(){
    if (invalid('#meal_name')){
      return false;
    }

    if (invalid('#meal_instructions')){
      return false;
    }

    if($('#meal_duration_hours').val() == '0' && $('#meal_duration_minutes').val() == '0'){
      $('#meal_duration_minutes').popover('show');
      return false;
    }

    var validIngredients = true;
    $('.ingredient').each(function(index) { 
      food = $(this).find('.food_select')
      if (invalid(food)){
        validIngredients = false;
        return false;
      }
      quantity = $(this).find('.number_select')
      if (invalid(quantity)){
        validIngredients = false;
        return false;
      }
      unitOfMeasurement = $(this).find('.unit_of_measurement_select')
      if (invalid(unitOfMeasurement)){
        validIngredients = false;
        return false;
      }
    });
    return validIngredients;
  });
})

