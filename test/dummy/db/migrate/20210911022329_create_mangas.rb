class CreateMangas < ActiveRecord::Migration[6.1]
  def change
    create_table :mangas do |t|
      t.string :name

      t.timestamps
    end
  end
end
