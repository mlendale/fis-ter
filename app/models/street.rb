class Street < ApplicationRecord
  validates :title, presence: true
  validates_numericality_of :from, allow_nil: true
  validates_numericality_of :to, allow_nil: true, greater_than: :from
end
