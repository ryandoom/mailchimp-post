class DataController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    render :text => logit(params) if params.present? && params.length > 2  #action & controller
  end

  def show
    render :text => logit(params) 
  end

  def update
  end  
  def create
    #curl --data "email=hello@world.com&id=xyzlmnop&list_id=12345689&name=whats up doc&misc1=misc1 data&mist2=mist 2 day" http://localhost:3000/data    
    render :text => logit(params)
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
  

    if !has_spam_content && params[:id].present? && params[:list_id].present? && params[:email].present?
      gb = Gibbon::API.new(params[:id])
      gb.lists.subscribe({:id => params[:list_id], :email => {:email => params[:email]}, :merge_vars => params, :double_optin => double_optin})
    end

    return params
  end
end
