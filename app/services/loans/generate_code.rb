class Loans::GenerateCode
  # This is a microservice to generate code, have an interface to call it
  def call(loan)
    loan.code = "#{SecureRandom.hex(8)}"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
