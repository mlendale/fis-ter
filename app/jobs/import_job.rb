require 'csv'

class ImportJob < ApplicationJob
  def perform(csv)
    CSV.foreach(csv, headers: true, encoding: 'ISO-8859-1', col_sep: ';') do |row|
      hashed_row = row.to_hash
      pop_intercom(hashed_row)
      pop_com(hashed_row)
    end
  end

  def get_intercom(siren)
    Intercommunality.find_by(siren: siren)
  end

  def get_commune(insee)
    Commune.find_by(code_insee: insee)
  end

  def pop_intercom(hash)
    form =  hash['form_epci'][0..2].downcase!
    if get_intercom(hash['siren_epci']).nil?
      Intercommunality.create!(name: hash['nom_complet'], siren: hash['siren_epci'], form: form, population: 0)
    end
  end

  def update_intercom_pop(intercom, pop)
    actual_pop = intercom.population
    intercom.update_attribute('population', actual_pop + pop.to_i)
  end

  def pop_com(hash)
    intercom = get_intercom(hash['siren_epci'])
    if get_commune(hash['insee']).nil?
      Commune.create!(name: hash['nom_com'], code_insee: hash['insee'], intercommunality_id: intercom.id,
                      population: hash['pop_total'])

      update_intercom_pop(intercom, hash['pop_total'])
    end
  end
end
