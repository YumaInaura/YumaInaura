class CreateExamples < ActiveRecord::Migration[7.0]
  def change
    create_table :examples do |t|
      t.string :name
      t.boolean :flag

      t.timestamps
    end
  end
end
