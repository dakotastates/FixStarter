class AddDeclareWinnerToProblems < ActiveRecord::Migration[6.0]
  def change
    add_column :problems, :declare_winner, :boolean, default: false
    add_column :proposals, :winner, :boolean, default: false
  end
end
