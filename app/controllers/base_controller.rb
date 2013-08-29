require 'open-uri'
class BaseController < ApplicationController

  helper :layout

  before_filter :detect_location

  def detect_location
    l = Hash.new
    l['CH'] = 'de-CH'
    l['DE'] = 'de-DE'
    l['UK'] = 'uk-UK'
    l['FR'] = 'fr-FR'
    l['RU'] = 'ru-RU'
    l['US'] = 'en-US'

   # json = open "http://api.hostip.info/get_json.php?ip=85.220.86.243"
   # country = ActiveSupport::JSON.decode(json);
   # puts country['country_code']

  end
end
