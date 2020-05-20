class Proposal < ApplicationRecord
  validates :title, uniqueness: true
  validates :title, :content, presence: true
  belongs_to :user
  belongs_to :problem
  has_many :materials, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :proposal_comments, dependent: :destroy
  has_many :users, through: :proposal_comments
  accepts_nested_attributes_for :materials, reject_if: proc { |attributes| attributes['quantity'].blank? || attributes['name'].blank?}

  #default_scope { order(created_at: :desc) }
end
