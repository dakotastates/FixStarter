class CreateProposalComments < ActiveRecord::Migration[6.0]
  def change
    create_table :proposal_comments do |t|
      t.string :content
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :proposal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
