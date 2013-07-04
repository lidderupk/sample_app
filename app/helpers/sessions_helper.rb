module SessionsHelper

  def sign_in(user)
  	logger.info "sign_in=> #{ current_user ? current_user.name.inspect : 'current_user is nil'}"
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
  	logger.info "SessionsHelper signed_in start"
    logger.info "#{current_user ? current_user.name.inspect : 'current_user is nil'}"
    logger.info "SessionsHelper signed_in end"
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

end
