class Loans::SendEmailJob
  include SuckerPunch::Job

  # This job performs the send email services in backgrount
  def perform(loan_id)
    loan = Loan.find(loan_id)
    Loans::SendEmail.new.call(loan)
  end
end
