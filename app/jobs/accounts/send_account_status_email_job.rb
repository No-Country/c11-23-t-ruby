class Accounts::SendAccountStatusEmailJob
  include SuckerPunch::Job

  # This job performs the send email services in backgrount
  def perform(account_id)
    account = Account.find(account_id)
    Accounts::SendAccountStatusEmail.new.call(account)
  end
end
