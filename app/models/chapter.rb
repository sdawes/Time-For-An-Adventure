class Chapter < ApplicationRecord

  belongs_to :adventure
  has_many :choices

  validates :description, :adventure_id, presence: true

end
