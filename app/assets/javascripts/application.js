//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){

  var my_textfield = $('.my_textfield')
  var my_button = $('.my_button')


  my_textfield.on("keyup", function(){
    console.log("task_list_form keyup event logged");
    if( my_textfield.val() !== "") {
      my_button.prop("disabled", false);
      $('.prepended').remove();
    }
  });


  my_button.on("click", function(){
    console.log("my_button click event logged");
    if( my_textfield.val() === "") {
      my_button.prop("disabled", true);

      $('#task_list_message').append('\<p class="prepended error">Can\'t leave textfield blank.</p>');
    }
  });
});


