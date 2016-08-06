require "wsato_gem/version"
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
end
