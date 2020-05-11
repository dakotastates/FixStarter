class Problem < ApplicationRecord
  validate :is_title_case
  before_validation :make_title_case

  has_many :problem_categories, dependent: :destroy
  has_many :categories, through: :problem_categories
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  belongs_to :user
  has_many :proposals, dependent: :destroy
  #has_many :votes, through: :proposals

  def categories_attributes=(categories_attributes)
    categories_attributes.values.each do |cat_attr|
      if cat_attr[:name].present?
        category = Category.find_or_create_by(cat_attr)
        if !self.categories.include?(category)
          self.problem_categories.build(category: category)
        end
      end
    end
  end

  def fields_blank?
    self.content.empty? || self.user.empty?
  end


  def self.by_user(user_id)
    where(user: user_id)
  end

  def self.by_category(category)
    where(category: category)
  end

  def self.from_today
    where("created_at >=?", Time.zone.today.beginning_of_day)
  end

  def self.yesterday

    @from = (Time.zone.now - 1.day).beginning_of_day.utc
    @to   = (Time.zone.now).beginning_of_day.utc
    #Entry.where(:created_at => @from..@to)
    where(:created_at => @from..@to)
  end

  def self.last_week
    @from = (Time.zone.now - 7.day).beginning_of_day.utc
    @to   = (Time.zone.now).beginning_of_day.utc
    #Entry.where(:created_at => @from..@to)
    where(:created_at => @from..@to)
  end

  def self.older
    where("created_at <?", Time.zone.now - 8.day)
  end

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
end
