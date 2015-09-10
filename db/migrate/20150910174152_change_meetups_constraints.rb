class ChangeMeetupsConstraints < ActiveRecord::Migration
  def up
    change_column :meetups, :title, :string, null: false, unique: true, length: { maximum: 50 }
  end

  def down
    change_column :meetups, :title, :string, null: false
  end
end
