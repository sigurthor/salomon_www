# This migration comes from a2 (originally 20130910112144)
class AddSalomonLocaleToCountry < ActiveRecord::Migration
  def change
    add_column :a2_countries, :salomon_locale, :string
  end
end
