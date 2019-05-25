require 'net/http'
require 'json'
require 'uri'

bch_price = 0

SCHEDULER.every '30m' do
  last_price = bch_price
  uri = URI.parse('https://api.coinbase.com/v2/prices/BCH-USD/spot')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  bch_price = json_response['data']['amount']
  bch_price = '%.2f' % bch_price.delete(',').to_f
  send_event('bchprice', { current: bch_price.to_f, last: last_price.to_f })
end
