class Transactions::ActivatedAccount < ActiveModel::Validator
  # This validates id account is activated
  def validate(record)
    unless record.account.status == "activated"
      record.errors.add :base, "Account is not activated."
    end
  end
end
