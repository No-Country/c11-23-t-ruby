class Transactions::GenerateTransfer
  # This is a microservice to generate code, have an interface to call it
  def call(transaction)
    # Find target_account with transaction options data
    target_account = Account.find_by(code: transaction.options["target_account"])
    # Generates transaccion from target_account
    target_account.transactions.create!(
      transaction_type: "deposit",
      amount: transaction.amount,
      options: {"from_account" => transaction.account.code}
    )
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
