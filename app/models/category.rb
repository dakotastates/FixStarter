class Category < ApplicationRecord
  has_many :proplem_categories
  has_many :problems, through: :problem_categories
end
