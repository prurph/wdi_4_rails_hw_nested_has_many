class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.name
      t.timestamps
    end
  end
end
