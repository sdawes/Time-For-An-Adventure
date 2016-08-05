class Choice < ApplicationRecord

  # belongs_to :chapter

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end
end
