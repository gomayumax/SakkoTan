require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/jsonp'
require 'yahoo_parse_api'

YahooParseApi::Config.app_id = 'dj0zaiZpPVhOT2VrU00xRVZ2dyZzPWNvbnN1bWVyc2VjcmV0Jng9NmQ-'

class SakkoTan < Sinatra::Base
  helpers Sinatra::Jsonp

  get '/' do
    str = params.key?('str') ? params['str'] : ''
    reading = reading(str)
    sakkotan = sakkotan(reading)
    result = { str: str, reading: reading, sakkotan: sakkotan }
    jsonp result
  end

  def reading(str)
    parsed = YahooParseApi::Parse.new.parse(str)
    parsed = parsed['ResultSet']['ma_result']['word_list']['word']
    
    reading = ''
    if parsed.instance_of?(Array)
      parsed.map {|word| reading += word['reading'] }
    elsif parsed.instance_of?(Hash)
      reading += parsed['reading']
    else
      abort '形態素解析失敗(´・ω・｀)'
    end

    reading
  end

  def sakkotan(str)
    pattern = {
      'さ' => 'た',
      'し' => 'てぃ',
      'す' => 'てゅ',
      'せ' => 'て',
      'そ' => 'と'
    }
    str.gsub(/[さしすせそ]/, pattern)
  end
end
