class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date, null: false

      t.timestamps null: false
    end
  end
end
