class Accounts::SendAccountStatusEmail
  # This is a microservice to send email with account status change
  def call(account)
    UserMailer.with(user: account.user, account: account).account_status_change_email.deliver!
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
