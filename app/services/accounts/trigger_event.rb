class Accounts::TriggerEvent
  def call(cup_test, event)
    cup_test.send "#{event}!"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
