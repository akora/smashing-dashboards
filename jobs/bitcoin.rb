require 'net/http'
require 'json'
require 'uri'

SCHEDULER.every '30m' do
  # Grab current bitcoin price from coinbase
  uri = URI.parse('https://api.coinbase.com/v2/prices/BTC-USD/spot')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)
  btc_price = json_response['data']['amount']
  btc_price = '%.2f' % btc_price.delete(',').to_f
  #puts btc_price
  # Grab bitcoin price from a day ago (coindesk hasn't given full support of it yet)
  uri = URI.parse('https://api.coindesk.com/v1/bpi/historical/close.json?for=yesterday')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  json_response = JSON.parse(response.body)

  # Either used Today or Yesterday because we're not sure which day the API will provide
  today = Time.now.strftime("%Y-%m-%d")
  yesterday = (Date.today-1).strftime('%Y-%m-%d')
  if json_response['bpi'][today]
    last_price = json_response['bpi'][today]
  elsif json_response['bpi'][yesterday]
    last_price = json_response['bpi'][yesterday]
  end
  last_price = '%.2f' % last_price.to_f

  # Send information to be processed
  send_event('btcprice', { value: btc_price.to_f, previous_price: last_price.to_f} )
end
