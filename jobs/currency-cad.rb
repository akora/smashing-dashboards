require 'net/http'
require 'json'
require 'uri'

cad_price = 0

SCHEDULER.every '30m' do
  last_price = cad_price
  uri = URI.parse('https://api.exchangeratesapi.io/latest?base=CAD&symbols=HUF')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  cad_price = json_response['rates']['HUF']
  cad_price = '%.2f' % cad_price.to_f
  send_event('cadprice', { current: cad_price.to_f, last: last_price.to_f })
end
