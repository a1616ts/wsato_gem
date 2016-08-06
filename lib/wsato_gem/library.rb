require 'json'

class LibrariesInNeihborhood
  @libraries
  @libraries_formalname_map
  attr_accessor :libraries, :libraries_formalname_map
end

class Library
  def self.search(address:, calilapp_key:, libraries_limit:)
    begin
      results = request_to_geocode_api(address: address)
      content = json.loads(results.content)
      location = content['results'][0]['geometry']['location']
      geocode = location['lng'].to_s << ',' << location['lat'].to_s

      results = request_to_calil_api(calilapp_key: calilapp_key, geocode: geocode, libraries_limit: libraries_limit)
      contents = JSON.parse(results.content)

      if contents.legth < 1
        output('お近くに図書館がないようです')
        raise
      else
        output('お近くの図書館を検索しました')
      end
      return libraries_in_neihborhood(content)
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
