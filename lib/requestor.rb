require "requestor/version"
require 'net/http'
require 'uri'
#require 'active_support/core_ext/string'
require 'requestor/internets_base'

module Requestor
  class RequestorError < StandardError
  end
  
  class ResponseError < RequestorError
  end
end
