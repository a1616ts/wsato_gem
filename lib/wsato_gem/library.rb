require 'open-uri'

def input()
    input = STDIN.gets() #
    if input.include?("exit")
        exit(0)
    end
    return input
end

def output(message)
    printf("library > %s", message)
end

def output_br()
    printf("library >")
end

def get_request(url)
    results = open(url)
    code, message = results.status # res.status => ["200", "OK"]
    if code != 200
        raise "HTTP error!" # => RuntimeError
    else
        return results
    end
end
