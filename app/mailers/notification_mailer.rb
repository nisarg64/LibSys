class NotificationMailer < ApplicationMailer
  default from: "notification@libsys.com"

  def send_mail(email, book, opts={})
    puts("------------------------------")
    puts ENV['GMAIL_USERNAME']
    puts("------------------------------")
    mail(from:'notification@libsys.com', to:email, subject: book + " is now available", body: "The book you were waiting for " + book + "  is available.")
  end
end
