class CreateUserActions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_actions do |t|
      t.string :content
      t.references :user
      t.timestamps null: false
    end
  end
end
