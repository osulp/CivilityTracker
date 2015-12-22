$(document).ready(function (){
  $('#civil_entry_reason').keyup(function(){
    if ($('#civil_entry_reason').val().trim().length > 0){
      $("input[type=submit]").prop("disabled", false); 
    }else{
      $("input[type=submit]").prop("disabled", false);
    }
  })
});
