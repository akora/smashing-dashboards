require 'net/http'
require 'json'
require 'uri'

SCHEDULER.every '30m' do
  uri = URI.parse('https://api.exchangeratesapi.io/latest?base=EUR&symbols=HUF')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  # puts json_response
  eur_price = json_response['rates']['HUF']
  eur_price = '%.2f' % eur_price.to_f
  # puts eur_price
  send_event('eurprice', { value: eur_price.to_f} )
end
