class Choice < ApplicationRecord

  belongs_to :chapter

  validates :option, :resulting_chapter_id, :chapter_id, presence: true

  before_save :normalize_blank_values

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end
end
