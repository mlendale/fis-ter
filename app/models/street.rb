class Street < ApplicationRecord
  has_many :communes, through: :commune_streets
  has_many :commune_streets

  validates :title, presence: true
  validates_numericality_of :from, allow_nil: true
  validates_numericality_of :to, allow_nil: true, greater_than: :from
end
