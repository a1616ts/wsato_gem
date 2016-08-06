require 'pry'
require 'json'
require 'set'

rakutenapi_key = 'xxxxx'
calilapp_key = 'xxxxx'


class LibrariesInNeihborhood
  @libraries
  @libraries_formalname_map
  attr_accessor :libraries, :libraries_formalname_map
end

class Library
  def get_request(a)
    return 'a'
  end

  # TODO 崩す
  def serch_libraries_in_neightbarhood()
    while true
      begin
        output_br
        output('現在地を入力してください')

        results = request_to_geocode_api(address: input)
        content = json.loads(results.content)
        location = content['results'][0]['geometry']['location']
        geocode = location['lng'].to_s << ',' << location['lat'].to_s

        results = request_to_calil_api(calilapp_key: calilapp_key, geocode: geocode)
        contents = JSON.parse(results.content)

        if contents.legth < 1
          output('お近くに図書館がないようです')
          raise
        else
          output('お近くの図書館を検索しました')
        end

        return libraries_in_neihborhood(content)
      rescue
        exit
      ensure
        continue
      end
    end
  end

  def request_to_geocode_api(address:)
    return get_request(
      'http://maps.google.com/maps/api/geocode/json?address=' +
      address + '&sensor=false')
  end

  def request_to_calil_api(calilapp_key:, geocode:)
    return get_request(
      'http://api.calil.jp/library?appkey=' <<
      calilapp_key << '&geocode=' << geocode <<
      '&limit=10&format=json&callback=')
  end

  def libraries_in_neihborhood(contents)
    lin = LibrariesInNeihborhood.new
    libraries_formalname_map = {}
    libraries = {}
    #system_ids = []
    contents.each do |content|
      #system_ids << content['systemid']
      key = content['systemid'] + content['libkey']
      libraries[key] = content['distance']
      libraries_formalname_map[key] = content['formal']
    end

    lin.libraries = libraries
    #lin.system_ids = system_ids
    lin.libraries_formalname_map = libraries_formalname_map
    #system_ids_set = Set.new(system_ids)
    #lin.system_ids_join = system_ids_set.to_a.join(',')
    return lin
  end
end
