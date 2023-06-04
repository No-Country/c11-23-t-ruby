module AccountsHelper
  # This helper shows the available events for an account with aasm gem
  def available_events_for(account)
    account.aasm.permitted_transitions.map { |t| t[:event] }
  end
end
