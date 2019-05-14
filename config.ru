if File.exist? '.env'
  require 'dotenv'
  Dotenv.load
end

require 'dashing'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  set :default_dashboard, 'time' # <== set default dashboard here

  # See http://www.sinatrarb.com/intro.html > Available Template Languages on
  # how to add additional template languages.
  set :template_languages, %i[html erb]

  helpers do
    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def authorized?
      return true if ENV['BASIC_AUTH_USERNAME'].nil? || ENV['BASIC_AUTH_PASSWORD'].nil?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [ENV['BASIC_AUTH_USERNAME'], ENV['BASIC_AUTH_PASSWORD']] # <== set these in your .env file
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
