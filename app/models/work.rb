class Work < ApplicationRecord
  has_many :votes

  CATEGORIES = %w(movie book album)

  validates :title, presence: true, uniqueness: true
  validates :category, inclusion: { in: CATEGORIES }
end
