require 'net/http'
require 'json'
require 'uri'

SCHEDULER.every '30m' do
  quote_number = rand(0..2)
  uri = URI.parse('https://s3.eu-west-2.amazonaws.com/kora.family-quotes/quotes.json')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  quote_en = json_response['quotes'][quote_number]['content']['en']
  quote_hu = json_response['quotes'][quote_number]['content']['hu']
  author = json_response['quotes'][quote_number]['author']['name']
  send_event('QuotesLocal', { quote_en: quote_en.to_s, quote_hu: quote_hu.to_s, author: author.to_s })
end
