//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){

  var my_textfield = $('.my_textfield')
  var my_button = $('.my_button')
  var clear_task_form = $('.clear_task_form')
  var assigned_to_message = $('#assigned_to_message')
  var assigned_to = $('.assigned_to')
  var datepicker = $('#datepicker')
  var my_input = $('.my_input')

  $(function() {
    $( "#datepicker" ).datepicker();
  });

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
      $('#task_list_message').append('\<p class="prepended error">Can\'t leave task list name blank.</p>');
      $('#task_message').append('\<p class="prepended error">Can\'t leave task description blank.</p>');
    }
    if ( my_textfield.val().length > 20) {
      my_button.prop("disabled", true);
      $('#task_list_message').append('\<p class="prepended error">Task List max limit is 20 characters</p>');
    }
    if ( assigned_to.val() === ""){
      my_button.prop("disabled", true);
      console.log("assigned to is blank")
      assigned_to_message.append('\<p class="prepended error">Need to assign the task to someone.</p>');
    }
    if (datepicker.val() == "" ) {
      my_button.prop("disabled", true);
      console.log("due date is blank")
      $('#new_due_date_message').append('\<p class="prepended error">Need to assign a due date.</p>');


    }
  });

  clear_task_form.on("click", function(){
    console.log("clear task form button event logged");
    my_textfield.val("");
    assigned_to.val("");
    datepicker.val("");

    $('.prepended').remove();
    my_button.prop("disabled", true);

  })

  $('.event').on("click", function(e){
    console.log(e.type);
  })

});


