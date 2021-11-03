class RenameMainToPrimaryOnAddresses < ActiveRecord::Migration[6.1]
  def change
    rename_column :addresses, :main, :primary
  end
end
