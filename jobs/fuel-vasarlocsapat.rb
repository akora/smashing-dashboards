require 'nokogiri'
require 'httparty'

fuel_price_only = 0

SCHEDULER.every '4h' do
  last_price = fuel_price_only
  url = "http://www.vasarlocsapat.hu/_hirek/_uzemanyag/uzemanyag-arak.shtml"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  fuel_price = parsed_page.css('th')[1].text
  fuel_price_only = fuel_price.slice(10..12).to_f
  # puts fuel_price_only
  send_event('fuelprice-vasarlocsapat', { current: fuel_price_only.to_f, last: last_price.to_f })
end
