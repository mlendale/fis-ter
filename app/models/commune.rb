class Commune < ApplicationRecord
  belongs_to :intercommunality
  has_many :streets, through: :commune_streets
  has_many :commune_streets

  validates :code_insee, :name, presence: true
  validates :code_insee, numericality: {only_integer: true}, length: {is: 5}
end
