class Transactions::ActivatedTargetAccount < ActiveModel::Validator
  # This validates id account is activated
  def validate(record)
    target_account = Account.find_by(code: record.options["target_account"])
    unless target_account.status == "activated"
      record.errors.add :base, "Target account is not activated."
    end
  end
end
