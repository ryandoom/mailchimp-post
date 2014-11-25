class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def log_google_analytics_event
    if params[:ga_tracking_id].present?
      analytics_params = {
        v: 1,
        tid: params[:ga_tracking_id],
        cid: params[:ga_client_id],
        t: "event",
        ec: params[:ga_category],
        ea: params[:ga_action],
        el: params[:ga_action],
        dh: params[:dh]
      }

      begin
        RestClient.get("http://www.google-analytics.com/collect", params: analytics_params, timeout: 4, open_timeout: 4)
        return true
      rescue  RestClient::Exception => rex
        return false

      end
    end
  end

  def authenticate_action
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |username, password|
        username == "webascender" && password == "rAj0Coit1thuB7uV4Paj0"
      end
    end
  end
end
