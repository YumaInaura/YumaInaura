class CreateSses < ActiveRecord::Migration[7.0]
  def change
    create_table :sses do |t|

      t.timestamps
    end
  end
end
