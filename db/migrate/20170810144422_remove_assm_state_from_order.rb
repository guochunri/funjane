class RemoveAssmStateFromOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :assm_state, :string
  end
end
