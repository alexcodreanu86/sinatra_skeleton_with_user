def current_user
  User.find(session[:user_id])
end

def current_user_id
  session[:user_id]
end