class AddPopulationToIntercommunality < ActiveRecord::Migration[5.0]
  def change
    add_column :intercommunalities, :population, :integer
  end
end
