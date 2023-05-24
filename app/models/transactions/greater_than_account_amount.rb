class Transactions::GreaterThanAccountAmount < ActiveModel::Validator
  # This validates id account amount is enough to output transaction
  def validate(record)
    if record.account.current_amount < record.amount
      record.errors.add :base, "The account amount is not enough."
    end
  end
end
