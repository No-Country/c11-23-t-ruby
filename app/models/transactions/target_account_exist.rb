class Transactions::TargetAccountExist < ActiveModel::Validator
  # This validates id account is activated
  def validate(record)
    target_account = Account.find_by(code: record.options["target_account"])
    if target_account == nil
      record.errors.add :base, "Target account does not exist."
    end
  end
end
