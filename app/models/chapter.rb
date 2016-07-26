class Chapter < ApplicationRecord

  belongs_to :adventure
  has_many :choices
  
end
