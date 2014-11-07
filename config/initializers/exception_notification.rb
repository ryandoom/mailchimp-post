MailchimpPost::Application.config.middleware.use ExceptionNotification::Rack,
  :email => {
    :email_prefix => "[MailchimpPost] ",
    :sender_address => %{"notifier" <notifier@mailchimp-post.herokuapp.com>},
    :exception_recipients => %w{matt.hall@webascender.com}
  }