require 'net/http'
require 'json'
require 'uri'

jpy_price = 0

SCHEDULER.every '30m' do
  last_price = jpy_price
  uri = URI.parse('https://api.exchangeratesapi.io/latest?base=JPY&symbols=HUF')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  jpy_price = json_response['rates']['HUF']
  jpy_price = '%.2f' % jpy_price.to_f
  send_event('jpyprice', { current: jpy_price.to_f, last: last_price.to_f })
end
