class ChangeQueryZipToString < ActiveRecord::Migration
  def change
    change_column :queries, :zip_code, :string
    rename_column :queries, :zip_code, :address_string
  end
end
