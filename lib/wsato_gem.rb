require_relative 'wsato_gem/version'
require_relative 'wsato_gem/library'

module WsatoGem
  def self.search_library(address:, calilapp_key:)
    return Library.new.search(address: address, calilapp_key: calilapp_key)
  end
end
