get '/' do
  @user = get_user_by_session
  erb :index
end


post '/' do 
  url = Url.find_by_url(params[:url])
  if url
    @user_return = url.generate_shortened
  else
    url = Url.new(url: params[:url], counter: 0) 
  end
  if url.save
    @user_return = url.generate_shortened
  end
  url.user_id = session[:user_id]
  url.save
  @user_return
end


def get_user_by_session
  if session[:user_id]
    User.find(session[:user_id])
  else
    nil
  end
end


get '/login' do
  redirect '/'
end

post '/login' do 
  user = User.find_by_name(params[:name])
  if user.check_password(params[:password])
    session[:user_id] = user.id
  end
  redirect '/'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end


get '/create' do 
  erb :create
end

post '/create' do 
  user = User.create(name: params[:name], password: params[:password])
  session[:user_id] = user.id
  redirect '/'
end

get '/users/:id' do |id|
  @display_user = User.find(id)
  @show_clicks = session[:user_id] == @display_user.id
  erb :profile
end

get '/:shortened' do |shortened|
  record = Url.find_by_shortened(shortened)
  record.increment
  url = record.url
  if url.start_with?("http:\/\/")
    redirect url
  else
    redirect "http://#{url}"
  end
end
