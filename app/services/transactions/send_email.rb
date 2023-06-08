class Transactions::SendEmail
  # This is a microservice to send email
  def call(transaction)
    UserMailer.with(user: transaction.account.user, account: transaction.account, transaction: transaction).new_transaction_email.deliver!
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
