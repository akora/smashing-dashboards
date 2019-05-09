require 'net/http'
require 'json'
require 'uri'

gbp_price = 0

SCHEDULER.every '30m' do
  last_price = gbp_price
  uri = URI.parse('https://api.exchangeratesapi.io/latest?base=GBP&symbols=HUF')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  # puts json_response
  gbp_price = json_response['rates']['HUF']
  gbp_price = '%.2f' % gbp_price.to_f
  # puts gbp_price
  send_event('gbpprice', { current: gbp_price.to_f, last: last_price.to_f })
end
