require 'net/http'
require 'json'
require 'uri'

xrp_price = 0

SCHEDULER.every '30m' do
  last_price = xrp_price
  uri = URI.parse('https://api.coinbase.com/v2/prices/XRP-USD/spot')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  xrp_price = json_response['data']['amount']
  xrp_price = '%.2f' % xrp_price.delete(',').to_f
  send_event('xrpprice', { current: xrp_price.to_f, last: last_price.to_f })
end
