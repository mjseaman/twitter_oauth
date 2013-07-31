$(document).ready(function() {

  console.log("in the doc ready function");
  $('#refresh_tweets').on('click', function() {
    request = $.ajax({
      url:'/tweets/',
      type:'get', 
      data: {username: window.location.pathname.match(/\w*$/)[0]}
    });

    request.done(function(data) {
      $('#paris_gif').replaceWith(data)
    });
  });

  $('.new_tweet').submit(function(e) {
    e.preventDefault();
    form = $(this);

    request = $.ajax({
      url:'/tweets/new',
      type:'post', 
      data: form.serialize()
    });

    request.done(function(data) {
      console.log("done!")
      $('.container').append('<p>Success!</p>')
      form.children(".clearable").val("");
    });

    request.fail(function(data) {
      $('.container').append('<p>Sorry, that tweet failed.</p>')
    });
  })
  
});


// window.location.pathname.match(/\w*$/)
