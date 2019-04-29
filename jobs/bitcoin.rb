require 'net/http'
require 'json'
require 'uri'

btc_price = 0

SCHEDULER.every '30m' do
  last_price = btc_price
  # Grab current bitcoin price from coinbase
  uri = URI.parse('https://api.coinbase.com/v2/prices/BTC-USD/spot')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  btc_price = json_response['data']['amount']
  btc_price = '%.2f' % btc_price.delete(',').to_f
  # Send information to be processed
  send_event('btcprice', { current: btc_price.to_f, last: last_price.to_f })
end
