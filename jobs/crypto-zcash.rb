require 'net/http'
require 'json'
require 'uri'

zec_price = 0

SCHEDULER.every '30m' do
  last_price = zec_price
  uri = URI.parse('https://api.coinbase.com/v2/prices/ZEC-USD/spot')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  zec_price = json_response['data']['amount']
  zec_price = '%.2f' % zec_price.delete(',').to_f
  send_event('zecprice', { current: zec_price.to_f, last: last_price.to_f })
end
