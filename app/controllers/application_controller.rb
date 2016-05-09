class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  helper_method :current_user_known_words_count
   def current_user_known_words_count
     @current_user_known_words_count ||= current_user.words.known_words.count
   end
end
