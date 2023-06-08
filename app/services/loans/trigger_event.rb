class Loans::TriggerEvent
  def call(loan, event)
    loan.send "#{event}!"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
