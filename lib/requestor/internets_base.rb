module Requestor
  class InternetsBase
    include Requestor::Hookifier
    include Requestor::InternetsBaseHooks
  
    def initialize(full_url, username = "", password = "")
      @full_url = full_url
      @username = username
      @password = password
    end

    def get
      url = URI.parse(@full_url)
      request = request_for(:get, url)
      response = Net::HTTP.start(url.host, url.port) { |http| http.request(request) }
      check(response).body
    end

    # TODO: Add tests for POST method if you need to use it - MRZ & MW
  
    # def post(form_data = {})
    #   url = URI.parse(@full_url)
    #   request = request_for(:post, url, form_data)
    #   response = Net::HTTP.start(url.host, url.port) do |http|
    #     http.request(request)
    #   end
    #   check(response).body
    # end
    
    hooked_methods :get
  
    private

    # TODO: Add tests for POST method if you need to use it - MRZ & MW
    def request_for(request_method, url, form_data = {})
      # if (request_method == :get)
      request = Net::HTTP::Get.new(url.request_uri)
      # else
      #   request = Net::HTTP::Post.new(url.path)
      #   request.set_form_data(form_data)
      # end
    
      request.basic_auth(@username, @password) unless @username.empty?
      request
    end

    def check(response)
      raise(Requestor::ResponseError, "Response was #{response.class} for #{@full_url}") unless response.class == Net::HTTPOK
      raise(Requestor::ResponseError, "Response body was blank for #{@full_url}") if response.body.empty?
      return response
    end

  end
end