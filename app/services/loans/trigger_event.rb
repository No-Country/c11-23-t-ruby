class Loans::TriggerEvent
  # This is a microservice to generate loan trigger event to change status
  def call(loan, event)
    loan.send "#{event}!"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
