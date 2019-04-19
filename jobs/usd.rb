require 'net/http'
require 'json'
require 'uri'

SCHEDULER.every '30m' do
  uri = URI.parse('https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  # puts json_response
  usd_price = json_response['rates']['HUF']
  usd_price = '%.2f' % usd_price.to_f
  # puts usd_price
  send_event('usdprice', { value: usd_price.to_f} )
end
