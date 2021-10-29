class CreateHowToUses < ActiveRecord::Migration[6.1]
  def change
    create_table :how_to_uses do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :section, default: 0
      t.text :content

      t.timestamps
    end
  end
end
