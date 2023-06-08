class Loans::SendLoanStatusChangeEmailJob
  include SuckerPunch::Job

  # This job performs the send email services in backgrount
  def perform(loan_id)
    loan = Loan.find(loan_id)
    Loans::SendLoanStatusChangeEmail.new.call(loan)
  end
end
