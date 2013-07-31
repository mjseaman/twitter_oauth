get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`

  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  p @access_token
  ap @access_token.params
  user = User.find_or_create_by_username(@access_token.params[:screen_name])
  user.oauth_token = @access_token.token
  user.oauth_secret = @access_token.secret
  user.save

  current_user = user
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  # at this point in the code is where you'll need to create your user account and store the access token

  redirect '/tweets/new'
  
end

get '/tweets/new' do
  erb :new_tweet
end

post '/tweets/new' do

  current_user.tweet(params[:tweet_text])
  
end

get '/status/:job_id' do
  # return the status of a job to an AJAX call
end