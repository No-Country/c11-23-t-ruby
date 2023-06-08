module ApplicationHelper
  include Pagy::Frontend

  # This helper shows the available events for an object with aasm status management
  def available_events_for(account)
    account.aasm.permitted_transitions.map { |t| t[:event] }
  end
end
