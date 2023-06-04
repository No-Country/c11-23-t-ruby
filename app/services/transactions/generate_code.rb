class Transactions::GenerateCode
  # This is a microservice to generate code, have an interface to call it
  def call(transaction)
    transaction.code = "TRS-#{SecureRandom.hex(8)}"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
