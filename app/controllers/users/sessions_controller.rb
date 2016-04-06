class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
#class Devise::SessionsController < DeviseController
  prepend_before_action :require_no_authentication, only: [:new, :create]
  prepend_before_action :allow_params_authentication!, only: :create
  prepend_before_action :verify_signed_out_user, only: :destroy
  prepend_before_action only: [:create, :destroy] { request.env["devise.skip_timeout"] = true }
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    #set_flash_message!(:notice, :signed_in)
    set_flash_message :notice, :signed_in
    sign_in(resource_name, resource)
      refresh_dom_with_partial('div#log', 'devise/menu/login_items')
      refresh_dom_with_partial('div#mes', 'devise/menu/message_items')
      refresh_dom_with_partial('div#reg', 'devise/menu/registration_items')
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out
      refresh_dom_with_partial('div#log', 'devise/menu/login_items')
      refresh_dom_with_partial('div#mes', 'devise/menu/message_items')
      refresh_dom_with_partial('div#reg', 'devise/menu/registration_items')
    yield if block_given?
    respond_to_on_destroy
  end

  protected

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { methods: methods, only: [:password] }
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end

  def translation_scope
    'devise.sessions'
  end

  private

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.
  def verify_signed_out_user
    if all_signed_out?
      set_flash_message :notice, :already_signed_out

      respond_to_on_destroy
    end
  end

  def all_signed_out?
    users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

    users.all?(&:blank?)
  end

  def respond_to_on_destroy 
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    # NOTE: the following has been replace with the last line in order to redirect to page upon signout -RLG
    #respond_to do |format|
    #  format.all { head :no_content }
      #redirect_to after_sign_out_path_for(resource_name)
    #  format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
    #end
    respond_with resource, location: after_sign_out_path_for(resource)
  end
end