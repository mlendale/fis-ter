class Intercommunality < ApplicationRecord
  has_many :communes

  validates :siren, :name, presence: true
  validates :form, inclusion: {in: %w(ca cu cc met)}
  validates :siren, uniqueness: true, numericality: {only_integer: true}, length: {is: 9}

  def communes_hash
    hash = Hash.new
    communes.each {|commune| hash[commune.code_insee.to_s] = commune.name}
    hash
  end

  def generate_slug
    if read_attribute(:slug).nil?
      write_attribute(:slug, ActiveSupport::Inflector.parameterize(name))
      save!
    end
    read_attribute(:slug)
  end

alias slug generate_slug
end
