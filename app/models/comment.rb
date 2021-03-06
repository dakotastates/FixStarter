class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :problem
  accepts_nested_attributes_for :user, reject_if: :all_blank
end
