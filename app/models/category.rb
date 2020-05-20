class Category < ApplicationRecord
  has_many :proplem_categories, dependent: :destroy
  has_many :problems, through: :problem_categories, dependent: :destroy
end
