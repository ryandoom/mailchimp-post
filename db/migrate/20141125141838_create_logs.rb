class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :post_type
      t.text :params

      t.timestamps
    end
  end
end
