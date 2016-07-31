class Adventure < ApplicationRecord

  has_many :chapters
  has_many :choices, through: :chapters 

  validates :title, uniqueness: true, presence: true
  validates :synopsis, presence: true

end
