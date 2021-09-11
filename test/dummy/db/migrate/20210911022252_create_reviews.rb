class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.belongs_to :reviewable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
