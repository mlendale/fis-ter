class Intercommunality < ApplicationRecord
  has_many :communes

  validates :siren, :name, presence: true
  validates :siren, uniqueness: true, numericality: {only_integer: true}, length: {is: 9}
  validates :form, inclusion: {in: %w(ca cu cc met)}

  def communes_hash
    hash = Hash.new
    communes.each {|commune| hash[commune.code_insee.to_s] = commune.name}
    hash
  end

end
