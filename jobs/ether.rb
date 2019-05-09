require 'net/http'
require 'json'
require 'uri'

eth_price = 0

SCHEDULER.every '30m' do
  last_price = eth_price
  uri = URI.parse('https://api.coinbase.com/v2/prices/ETH-USD/spot')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  eth_price = json_response['data']['amount']
  eth_price = '%.2f' % eth_price.to_f
  #puts eth_price
  send_event('ethprice', { current: eth_price.to_f, last: last_price.to_f })
end
