class Proposal < ApplicationRecord
  belongs_to :user
  belongs_to :problem
  has_many :materials, dependent: :destroy
  has_many :votes
  accepts_nested_attributes_for :materials, reject_if: proc { |attributes| attributes['quantity'].blank? || attributes['name'].blank?}
end
