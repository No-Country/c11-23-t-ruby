class Loans::SendLoanStatusChangeEmail
  # This is a microservice to send email
  def call(loan)
    account = loan.account
    UserMailer.with(user: account.user, account: account, loan: loan).loan_status_change_email.deliver!
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
