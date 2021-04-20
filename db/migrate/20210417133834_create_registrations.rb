class CreateRegistrations < ActiveRecord::Migration[6.1]
  def change
    create_table :registrations do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :code
      t.datetime :expires

      t.timestamps
    end
  end
end
