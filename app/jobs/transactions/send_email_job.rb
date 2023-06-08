class Transactions::SendEmailJob
  include SuckerPunch::Job

  # This job performs the send email services in backgrount
  def perform(transaction_id)
    transaction = Transaction.find(transaction_id)
    Transactions::SendEmail.new.call(transaction)
  end
end
