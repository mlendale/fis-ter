class Intercommunality < ApplicationRecord
  has_many :communes

  validates :siren, :name, presence: true
  validates :form, inclusion: {in: %w(ca cu cc met)}
  validates :siren, uniqueness: true, numericality: {only_integer: true}, length: {is: 9}

  before_save :slug

  def communes_hash
    hash = Hash.new
    communes.each {|commune| hash[commune.code_insee.to_s] = commune.name}
    hash
  end

  def slug
    if name and read_attribute(:slug).nil?
      write_attribute(:slug, ActiveSupport::Inflector.parameterize(name))
    end
    read_attribute(:slug)
  end
end
