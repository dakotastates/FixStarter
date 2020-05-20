class AddFirstNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :about_me, :text
    add_column :users, :age, :integer
  end
end
