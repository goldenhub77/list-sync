require 'mailgun'

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@lystsync.com'
  layout 'mailer'

  def domain
    ENV['MG_DOMAIN']
  end

  def from
    'no-reply@lystsync.com'
  end

  def client
    @client ||= Mailgun::Client.new(ENV['MG_API_KEY'])
  end

  def batch_builder()
    mg_obj = Mailgun::BatchMessage.new(client, domain)
    mg_obj.from(from)
    mg_obj
  end
end
