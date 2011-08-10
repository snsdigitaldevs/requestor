require "requestor/version"
require 'net/http'
require 'uri'
require 'logger'
#require 'active_support/core_ext/string'

require 'requestor/hookifier'
require 'requestor/internets_base_hooks'

require 'requestor/internets_base'
require 'requestor/audit'

module Requestor
  
  class RequestorError < StandardError
  end
  
  class ResponseError < RequestorError
  end
end
