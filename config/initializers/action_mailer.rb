ActionMailer::DeliveryJob.rescue_from(Mailgun::CommunicationError) do |exception|
    Rails.logger.error "Mailgun server is not available, network issue possible no internet connection. Error - #{exception}"
end
