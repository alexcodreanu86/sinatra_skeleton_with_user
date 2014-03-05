get '/users/new' do 
  erb :"user_views/sign_up"
end

get '/users/login' do
  erb :"user_views/login"
end

get '/users/show' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    erb :"user_views/show"
  else
    @errors = {:Invalid => ["Not logged in yet"]}
    erb :index
  end
end

get '/users/edit' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    erb :"user_views/edit"
  else
    @errors = {:Invalid => ["Not logged in yet"]}
    erb :index
  end
end

get "/users/logout" do 
  session.clear
  redirect to('/')
end


post '/users/new' do
  @user = User.create(params[:user])
  redirect to('/')
end

post '/users/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to('/users/show')
  else
    @errors = {:Invalid => ["Invalid email or password"]}
    erb :"user_views/login"
  end
end

post "/users/edit" do
  @user = current_user 
  if @user && @user.authenticate(params[:old_password])
    @user.update(params[:user])
    if @user.save
      redirect to('/users/show')
    else
      @errors = @user.errors.messages
    end
  else
    @errors = {:Invalid  => ["Something went wrong"]}
  end
  erb :"user_views/edit"
end


