class Intercommunality < ApplicationRecord
  validates :siren, :name, presence: true
  validates :siren, uniqueness: true, numericality: {only_integer: true}, length: {is: 9}
  validates :form, inclusion: {in: %w(ca cu cc met)}
end
