class Loans::GenerateLoanDeposit
  # This is a microservice to generate code, have an interface to call it
  def call(loan)
    loan.account.transactions.create!(
      amount: loan.amount,
      transaction_type: "deposit",
      options: { "from_loan" => loan.code }
    )
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
