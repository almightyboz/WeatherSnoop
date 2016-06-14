class AddMonthDayYearToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :day, :string
    add_column :queries, :month, :string
    add_column :queries, :year, :string
  end
end
