class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :genre
      t.string :rating
      t.string :image
      t.string :watch_link
      t.integer :user_id
    end
  end
end
