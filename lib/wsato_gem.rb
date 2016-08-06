require "wsato_gem/version"

module WsatoGem
  def search_library(address:, calilapp_key:)
    return Library.new.search(address:, calilapp_key:)
  end
end
