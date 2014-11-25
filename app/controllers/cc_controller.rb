class CcController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :log_google_analytics_event

  def index
    Log.create(:post_type => "MailChimp", :params => params)
    @error = "No parameters received!" unless params.present? && params.length > 2  #action & controller
    @error = "ID not found!" unless params.has_key? :id
    @error = "No API Key received!" unless params.has_key? :api_key
    @error = "No contact params received!" unless params.has_key? :contact
    if @error.present?
      render :text => @error
    else
      logit(params)
      @lists = @ccapi.get_lists(params[:id])
    end
  end

  def show
    render :text => logit(params)
  end

  def update
  end
  def create
    #curl --data "email=hello@world.com&id=xyzlmnop&list_id=12345689&first_name=Walter&last_name=White&misc1=misc1 data&mist2=mist 2 day" http://localhost:3000/cc
    render :text => logit(params)
  end

  def auth
  end

  def auth_start
    session[:api_key] = params[:api_credentials][:api_key]
    session[:api_secret] = params[:api_credentials][:api_secret]
    session[:redirect_url] = cc_auth_end_url
    @oauth = init_oauth
    redirect_to @oauth.get_authorization_url
  end

  def auth_end
    @oauth = init_oauth

    @error = params[:error]
    @code = params[:code]
    @user = params[:username]

    if @code.present?
      response = @oauth.get_access_token(@code)
      @token = response['access_token'] if response.present?

      @ccapi = ConstantContact::Api.new(session[:api_key])
      @lists = @ccapi.get_lists(@token)
    end
  end

  def logit(params)
    params.delete(:action)
    params.delete(:controller)

    double_optin = params[:double_optin].present? ? params[:double_optin] : false

    email_message = params[:message].present? ? params[:message] : ""
    #email_message = "WE are Wizard LinKBuilding experts who LOves the SKYpes and I don't Want you ON my MAILCHIMP... you mad BRO?"
    email_message.downcase!
    blacklist = ["india","linkbuilding","outsource","skype","iso 9001","cmmi","outsourcing","usd","madam","skype","link building","drugs","pharmacy","cheap"]
    has_spam_content = blacklist.count {|bl| email_message.include? bl} != 0

    if !has_spam_content && params.has_key?(:id) && params.has_key?(:api_key) && params.has_key?(:list_id) && params.has_key?(:contact)
      @ccapi = ConstantContact::Api.new(params[:api_key])
      begin
        @contact = params[:contact]
        @email = @contact[:email] || params[:email]

        contact_params = params[:contact]
        contact_params['email_addresses'] = [{:email_address => @email}]
        contact_params['lists'] = [{:id => "#{params[:list_id]}"}]

        # list = @ccapi.get_list(params[:id], params[:list_id])

        response = @ccapi.get_contact_by_email params[:id], @email
        contact = ConstantContact::Components::Contact.create contact_params
        if response && response.respond_to?(:results) && response.results.any?
          contact.id = response.results.first.id.to_s
          @ccapi.update_contact params[:id], contact
        else
          @ccapi.add_contact params[:id], contact
        end
      end
    end

    return params
  end

  private
  def init_oauth
    ConstantContact::Auth::OAuth2.new :api_key => session[:api_key],
                                      :api_secret => session[:api_secret],
                                      :redirect_url => session[:redirect_url]
  end

end
