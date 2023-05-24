class AddOptionsToTransactions < ActiveRecord::Migration[7.0]
  enable_extension 'hstore' unless extension_enabled?('hstore')
  def change
    add_column :transactions, :options, :hstore, default: {}
  end
end
