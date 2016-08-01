class Chapter < ApplicationRecord

  belongs_to :adventure
  has_many :choices

  accepts_nested_attributes_for :choices
  
  # validates :description, :adventure_id, presence: true
end
