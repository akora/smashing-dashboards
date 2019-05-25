require 'net/http'
require 'json'
require 'uri'

aud_price = 0

SCHEDULER.every '30m' do
  last_price = aud_price
  uri = URI.parse('https://api.exchangeratesapi.io/latest?base=AUD&symbols=HUF')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  # puts json_response
  aud_price = json_response['rates']['HUF']
  aud_price = '%.2f' % aud_price.to_f
  # puts aud_price
  send_event('audprice', { current: aud_price.to_f, last: last_price.to_f })
end
