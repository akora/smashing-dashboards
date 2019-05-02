require 'nokogiri'
require 'httparty'

fuel_price_only = 0

SCHEDULER.every '2m' do
  last_price = fuel_price_only
  url = "https://holtankoljak.hu"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  fuel_price = parsed_page.css('td.price.avg')[0].css("strong").text
  fuel_price_only = fuel_price.slice(0..4).to_f
  # puts fuel_price_only
  send_event('fuelprice-holtankoljak', { current: fuel_price_only.to_f, last: last_price.to_f })
end
