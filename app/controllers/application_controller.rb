class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #before_action :all_tasks, only: [:index, :create]
  protect_from_forgery with: :exception
  respond_to :html, :js



  after_filter :set_csrf_cookie_for_ng
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected
    def verified_request?
      super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    end
  private
    def ensure_trailing_slash
     redirect_to url_for(params.merge(:trailing_slash => true)), :status => 301 unless trailing_slash?
    end

    def trailing_slash?
      request.env['REQUEST_URI'].match(/[^\?]+/).to_s.last == '/'
    end

    private

  # Overwriting the sign_out redirect path method
  def after_sign_in_path_for(resource_or_scope)
    stock_user_lists_path

  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
     root_path
  end

 end
