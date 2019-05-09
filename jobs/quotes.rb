require 'net/http'
require 'json'
require 'uri'

SCHEDULER.every '30m' do
  uri = URI.parse('https://wisdomapi.herokuapp.com/v1/random')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  author = json_response['author']['name']
  company = json_response['author']['company']
  quote = json_response['content']
  send_event('Quotes', { author: author.to_s, company: company.to_s, quote: quote.to_s })
end
