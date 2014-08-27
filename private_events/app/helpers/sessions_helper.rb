module SessionsHelper

  def current_user
    @current_user ||= User.find_by username: session[:username]
  end

  def signed_in?
    !current_user.nil?
  end

  def signin user
    session[:username] = user.username
  end

  def signout
    session[:username] = nil
  end

end