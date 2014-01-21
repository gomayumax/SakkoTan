require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/jsonp'

class SakkoTan < Sinatra::Base
  helpers Sinatra::Jsonp

  get '/' do
    str = params.key?('str') ? params['str'] : ''
    data = { str: str }
    jsonp data
  end
end
