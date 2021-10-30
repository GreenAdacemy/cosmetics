class ChangeColumnFromBenefits < ActiveRecord::Migration[6.1]
  def change
    change_column :benefits, :value, :text
  end
end
