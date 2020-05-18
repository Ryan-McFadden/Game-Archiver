class CreateGames < ActiveRecord::Migration[6.0]

  def change
    create_table :games do |t|
      t.string :title
      t.integer :date
      t.string :description
      t.integer :user_id
    end
  end

end
