class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :liked_user, foreign_key: { to_table: :users } # Correct table reference

      t.timestamps
    end
  end
end
