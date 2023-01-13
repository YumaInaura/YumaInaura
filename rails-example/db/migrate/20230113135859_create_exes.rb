class CreateExes < ActiveRecord::Migration[7.0]
  def change
    create_table :exes do |t|
      t.string :message

      t.timestamps
    end
  end
end
