class Transactions::ActivatedTargetAccount < ActiveModel::Validator
  # This validates id account is activated
  def validate(record)
    target_account = Account.find_by(code: record.options["target_account"])
    unless target_account.status == "activated"
      record.errors.add :base, "Cuenta destino no se encuentra activa."
    end
  end
end
