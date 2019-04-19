require 'nokogiri'
require 'httparty'

SCHEDULER.every '4h' do
  url = "http://www.vasarlocsapat.hu/_hirek/_uzemanyag/uzemanyag-arak.shtml"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  fuel_price = parsed_page.css('th')[1].text
  fuel_price_only = fuel_price.slice(10..12)
  # puts fuel_price_only
  send_event('fuelprice-vasarlocsapat', { value: fuel_price_only.to_f} )
end
