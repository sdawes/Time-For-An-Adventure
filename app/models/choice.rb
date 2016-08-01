class Choice < ApplicationRecord

  belongs_to :chapter

  validates :option, :resulting_chapter_id, :chapter_id, presence: true

  before_save :normalize_blank_values

  before_create :build_chapter

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end
end
