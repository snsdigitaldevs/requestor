require File.dirname(__FILE__) + '/spec_helper'

describe "Requestor::InternetsBase" do

  describe "get" do
    
    before(:each) do
      @connection = mock("connection")
      @requestor = Requestor::InternetsBase.new("http://www.simon.com/blah.html?anything=1")
      @requestor.stub!(:create_http_connection).and_return @connection
    end
    
    it "should make a get request" do
      @requestor.stub!(:check).and_return mock(:response, :body => nil)
      @connection.stub!(:start)
      Net::HTTP::Get.should_receive(:new).with("/blah.html?anything=1").and_return mock(:request)
      @requestor.get
    end
  
    it "should return valid response when 200 and body is not empty" do
      response = Net::HTTPResponse::CODE_TO_OBJ['200'].new("2.0", 200, "valid message")
      @connection.stub!(:start).and_return(response)
      response.stub!(:body).and_return('response body')

      @requestor.get.should == "response body"
    end
    
    it "should raise error if response code is not 200" do
      response = Net::HTTPResponse::CODE_TO_OBJ['500'].new("2.0", 500, "Internal Server Error")
      @connection.stub!(:start).and_return(response)      
      lambda{
        @requestor.get
      }.should raise_error(Requestor::ResponseError, "Response was Net::HTTPInternalServerError for http://www.simon.com/blah.html?anything=1")
    end
    
    it "should raise error if response code is 200 and response body is empty" do
      response = Net::HTTPResponse::CODE_TO_OBJ['200'].new("2.0", 200, "valid messsage")
      @connection.stub!(:start).and_return(response)
      response.stub!(:body).and_return('')
      lambda{
        @requestor.get
      }.should raise_error(Requestor::ResponseError, "Response body was blank for http://www.simon.com/blah.html?anything=1")
    end
    
    it "should authenticate using basic auth if username is provided" do
      request = mock("request")
      connection = mock("connection", :start => "")
      requestor = Requestor::InternetsBase.new("http://www.simon.com/blah.html?anything=1", "admin", "pass")
      requestor.stub!(:check).and_return mock(:response, :body => nil)
      requestor.stub!(:create_http_connection).and_return connection
      Net::HTTP::Get.stub!(:new).and_return request
      request.should_receive(:basic_auth).with("admin", "pass")
      requestor.get
    end
    
    it "should not authenticate using basic auth if username is not provided" do
      @requestor.stub!(:check).and_return mock(:response, :body => nil)
      request = mock("request")
      @connection.stub!(:start)
      Net::HTTP::Get.stub!(:new).and_return request
      request.should_not_receive(:basic_auth)
      @requestor.get
    end
    
    it "should always set open timeout and read timeout to 120 seconds" do
        requestor = Requestor::InternetsBase.new("http://www.simon.com/blah.html?anything=1")
        url = mock("url", :host => "www.simon.com", :port => 8888)
        connection = Net::HTTP.new(url.host, url.port)
        Net::HTTP.should_receive(:new).with("www.simon.com", 8888).and_return(connection)

        requestor.send(:create_http_connection, url)
        connection.open_timeout.should == 120
        connection.read_timeout.should == 120
    end
    
  end
  
end