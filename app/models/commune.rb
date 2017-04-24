class Commune < ApplicationRecord
  belongs_to :intercommunality, optional: true
  has_many :streets, through: :commune_streets
  has_many :commune_streets

  validates :code_insee, :name, presence: true
  validates :code_insee, length: {is: 5}

  def self.search(name)
    pattern = Regexp.union("\\", "%", "_")
    sanitized_name = name.gsub(pattern) { |char| ["\\", char].join }
    Commune.where("name LIKE ?", "%#{sanitized_name.downcase}%")
  end

  def self.to_hash
    hash = Hash.new
    Commune.find_each {|commune| hash[commune.code_insee.to_s] = commune.name}
    hash
  end
end
