require 'json'
require 'open-uri'

def input()
    input = STDIN.gets()
    if input.include?("exit")
        exit(0)
    end
    return input
end

def output(message)
    printf("library > %s\n", message)
end

def output_br()
    printf("library >\n")
end

def get_request(url)
    results = open(url)
    code, message = results.status # res.status => ["200", "OK"]
    if code != '200'
        raise "HTTP error!" # => RuntimeError
    else
        return results.read
    end
end

class Library
  def search(address:, calilapp_key:, libraries_limit: 30)
    begin
      results = request_to_geocode_api(address: address)
      contents = JSON.load(results)
      location = contents['results'][0]['geometry']['location']
      geocode = location['lng'].to_s << ',' << location['lat'].to_s

      results = request_to_calil_api(calilapp_key: calilapp_key, geocode: geocode, libraries_limit: libraries_limit)
      contents = JSON.parse(results)
      if contents.length < 1
        output('お近くに図書館がないようです')
        raise
      else
        output('お近くの図書館を検索しました')
        output_br
        libraries = libraries_in_neihborhood(contents)
        libraries.each do | distance, formal_name |
          output("#{distance} km  #{formal_name}")
        end
        return libraries
      end
    rescue
      raise
    end
  end

  def request_to_geocode_api(address:)
    return get_request(
      'http://maps.google.com/maps/api/geocode/json?address=' +
      address + '&sensor=false')
  end

  def request_to_calil_api(calilapp_key:, geocode:, libraries_limit: 10)
    return get_request(
      'http://api.calil.jp/library?appkey=' <<
      calilapp_key << '&geocode=' << geocode <<
      '&limit=' + libraries_limit.to_s + '&format=json&callback=')
  end

  def libraries_in_neihborhood(contents)
    libraries = {}
    contents.each do |content|
      libraries[content['distance']] = content['formal']
    end
    return Hash[libraries.sort]
  end
end
