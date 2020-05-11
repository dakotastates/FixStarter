class AddStatusToProblems < ActiveRecord::Migration[6.0]
  def change
    add_column :problems, :status, :boolean, default: false
    add_column :problems, :priority, :string

  end
end
