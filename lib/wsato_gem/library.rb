require 'open-uri'

module WsatoGem
	def input()
		input = raw_input()
	  if input.include?("exit")
	  	exit(0)
	  return input
	end
	
	def output(message):
		printf("library > %s", message)
	end
	
	def output_br():
		printf("library >")
	end
	
	def get_request(url)
		results = open(url)
		code, message = results.status # res.status => ["200", "OK"]
		if code != 200
			raise "HTTP error!" # => RuntimeError
		else:
			return results
	end
	
require 'pry'
require 'json'
require 'set'
require 'open-uri'

rakutenapi_key = 'xxxxx'
calilapp_key = 'xxxxx'


class LibrariesInNeihborhood

end

def input()
	input = raw_input()
	if input.include?("exit")
		exit(0)
	return input
end

def output(message):
	printf("library > %s", message)
end

def output_br():
	printf("library >")
end

def get_request(url)
	results = open(url)
	code, message = results.status # res.status => ["200", "OK"]
	if code != 200
		raise "HTTP error!" # => RuntimeError
	else:
		return results
end

def serch_libraries_in_neightbarhood()
  libraries_in_neihborhood = LibrariesInNeihborhood.new
  while true
    begin
      output_br
      output('現在地を入力してください')
      results = request_to_geocode_api(input)
      content = json.loads(results.content)
      location = content['results'][0]['geometry']['location']
      geocode = location['lng'].to_s << ',' << location['lat'].to_s

      results = request_to_calil_api(geocode: geocode, calilapp_key: calilapp_key)
      contents = JSON.parse(results.content)

      if contents.legth < 1
        output('お近くに図書館がないようです')
        raise
      else
        output('お近くの図書館を検索しました')
      end

      system_ids = []
      libraries = {}
      libraries_formalname_map = {}

      content.each do |content|
        system_ids << content['systemid']
        key = content['systemid'] << content['libkey']
        libraries[key] = content['distance']
        libraries_formalname_map[key] = content['formal']

        libraries_in_neihborhood.libraries = libraries
        libraries_in_neihborhood.system_ids = system_ids
        libraries_in_neihborhood.libraries_formalname_map = libraries_formalname_map

        system_ids_set = Set.new(system_ids)
        libraries_in_neihborhood.system_ids_join = system_ids_set.to_a.join(',')
        return libraries_in_neihborhood
      end
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

def request_to_calil_api(geocode:, calilapp_key:)
  return get_request(
    'http://api.calil.jp/library?appkey=' +
    calilapp_key + '&geocode=' + geocode +
    '&limit=10&format=json&callback=')
end
