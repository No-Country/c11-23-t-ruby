class Accounts::SendEmail
  # This is a microservice to send email
  def call(account)
    UserMailer.with(user: account.user, account: account).new_account_email.deliver!
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
