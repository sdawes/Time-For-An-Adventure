class Game < ApplicationRecord
  belongs_to :user
  belongs_to :adventure

  validates :user_id, presence: true
  validates :adventure_id, presence: true
  validates :chapters, presence: true
  
end
