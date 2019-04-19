require 'nokogiri'
require 'httparty'

SCHEDULER.every '4h' do
  url = "https://holtankoljak.hu"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  fuel_price = parsed_page.css('td.price.avg')[0].css("strong").text
  fuel_price_only = fuel_price.slice(0..4)
  # puts fuel_price_only
  send_event('fuelprice-holtankoljak', { value: fuel_price_only.to_f} )
end
