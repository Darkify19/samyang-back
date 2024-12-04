class Photo < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }
  validates :position, numericality: { greater_than: 0, less_than_or_equal_to: 5 }, allow_nil: true
end
