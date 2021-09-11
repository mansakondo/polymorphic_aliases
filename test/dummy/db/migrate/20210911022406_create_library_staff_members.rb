class CreateLibraryStaffMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :library_staff_members do |t|
      t.string :name

      t.timestamps
    end
  end
end
