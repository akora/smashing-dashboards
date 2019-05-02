require 'net/http'
require 'json'
require 'uri'

bat_price = 0

SCHEDULER.every '2m' do
  last_price = bat_price
  # Grab current bitcoin price from coinbase
  uri = URI.parse('https://api.coinbase.com/v2/prices/BAT-USD/spot')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  bat_price = json_response['data']['amount']
  bat_price = '%.4f' % bat_price.delete(',').to_f
  # Send information to be processed
  send_event('batprice', { current: bat_price.to_f, last: last_price.to_f })
end
