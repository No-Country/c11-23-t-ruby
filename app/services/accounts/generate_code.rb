class Accounts::GenerateCode
  # This is a microservice to generate code, have an interface to call it
  def call(account)
    account.code = "#{SecureRandom.hex(8)}"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
