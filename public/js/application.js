$(document).ready(function() {
  $('form[name="url"]').on("submit",function(e){
    e.preventDefault();
    $.ajax({
      url: "/",
      type: "post",
      data: $(this).serialize()
    }).done(function(response){
      x = window.location.host;
      $("input[name='url']").val(x+'/'+response);
      $("input[name='url']").focus();
      $("input[name='url']").select();
    });
  });
});
