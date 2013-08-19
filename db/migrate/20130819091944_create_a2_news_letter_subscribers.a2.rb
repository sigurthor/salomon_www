# This migration comes from a2 (originally 20130819084620)
class CreateA2NewsLetterSubscribers < ActiveRecord::Migration
  def change
    create_table :a2_news_letter_subscribers do |t|
      t.string :email
      t.string :country
      t.string :city
      t.string :ip_address

      t.timestamps
    end
  end
end
