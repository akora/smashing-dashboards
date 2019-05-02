require 'net/http'
require 'json'
require 'uri'

lite_price = 0

SCHEDULER.every '2m' do
  last_price = lite_price
  uri = URI.parse('https://api.coinbase.com/v2/prices/LTC-USD/spot')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  lite_price = json_response['data']['amount']
  lite_price = '%.2f' % lite_price.to_f
  #puts lite_price
  send_event('liteprice', { current: lite_price.to_f, last: last_price.to_f })
end
