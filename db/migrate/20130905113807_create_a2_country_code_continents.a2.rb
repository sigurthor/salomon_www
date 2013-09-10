# This migration comes from a2 (originally 20130905111248)
class CreateA2CountryCodeContinents < ActiveRecord::Migration
  def change
    create_table :a2_country_code_continents do |t|
      t.string :country_code
      t.string :continent_code
    end

    add_index :a2_country_code_continents, :country_code, :unique => true
  end
end
