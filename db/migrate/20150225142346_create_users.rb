class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :cxbid
      t.string :comment
      t.float :rp, default: 0.00
      t.datetime :skill_updated_at

      t.timestamps
    end
  end
end
