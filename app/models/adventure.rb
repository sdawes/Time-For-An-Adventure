class Adventure < ApplicationRecord

  has_many :chapters

  validates :title, uniqueness: true, presence: true
  validates :synopsis, presence: true

end
