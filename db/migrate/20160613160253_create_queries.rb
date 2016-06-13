class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer :zip_code

      t.timestamps null: false
    end
  end
end
