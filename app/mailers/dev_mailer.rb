class DevMailer < ActionMailer::Base
  include Resque::Mailer
  default :from => "no-reply@recommendationengine.co"
  FROM_EMAIL = "RecEngine <no-reply@recommendationengine.co>"
  TO_EMAIL = "daifu.ye@gmail.com"

  def send_error(caller, backtrace, message, class_name)
    mail_hash = {
      :to => TO_EMAIL,
      :from => FROM_EMAIL,
      :subject => "RecEngine Error [#{Rails.env}] at #{caller}"
    }
    @caller, @backtrace, @message, @class_name = caller, backtrace, message, class_name
    @time = Time.zone.now.strftime("%m/%d/%Y %I:%M %p %Z")
    mail(mail_hash)
  end
end