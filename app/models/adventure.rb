class Adventure < ApplicationRecord

  has_many :chapters

  validates :title, uniqueness: true

end
