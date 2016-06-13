class CreateUserQueries < ActiveRecord::Migration
  def change
    create_table :user_queries do |t|
      t.references :user
      t.references :query

      t.timestamps null: false
    end
  end
end
