require 'net/http'
require 'json'
require 'uri'

chf_price = 0

SCHEDULER.every '2m' do
  last_price = chf_price
  uri = URI.parse('https://api.exchangeratesapi.io/latest?base=CHF&symbols=HUF')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  # puts json_response
  chf_price = json_response['rates']['HUF']
  chf_price = '%.2f' % chf_price.to_f
  # puts chf_price
  send_event('chfprice', { current: chf_price.to_f, last: last_price.to_f })
end
