require File.dirname(__FILE__) + 'spec_helper'

describe "InternetsRequestor" do

  describe "get" do
    
    before(:each) do
      @requestor = InternetsRequestor.new("http://www.simon.com/blah.html?anything=1")
    end
    
    it "should make a get request" do
      @requestor.stub!(:check).and_return mock(:response, :body => nil)
      Net::HTTP.stub!(:start)
      
      Net::HTTP::Get.should_receive(:new).and_return mock(:request)
      @requestor.get
    end
  
    it "should return valid response when 200 and body is not empty" do
      response = Net::HTTPResponse::CODE_TO_OBJ['200'].new("2.0", 200, "valid message")
      Net::HTTP.stub!(:start).and_return(response)
      response.stub!(:body).and_return('response body')

      @requestor.get.should == "response body"
    end
    
    it "should raise error if response code is not 200" do
      response = Net::HTTPResponse::CODE_TO_OBJ['500'].new("2.0", 500, "Internal Server Error")
      Net::HTTP.stub!(:start).and_return(response)      
      lambda{
        @requestor.get
      }.should raise_error(Gateways::ResponseError, "Response was Net::HTTPInternalServerError for http://www.simon.com/blah.html?anything=1")
    end
    
    it "should raise error if response code is 200 and response body is empty" do
      response = Net::HTTPResponse::CODE_TO_OBJ['200'].new("2.0", 200, "valid messsage")
      Net::HTTP.stub!(:start).and_return(response)
      response.stub!(:body).and_return('')
      lambda{
        @requestor.get
      }.should raise_error(Gateways::ResponseError, "Response body was blank for http://www.simon.com/blah.html?anything=1")
    end
    
    it "should authenticate using basic auth if username is provided" do
      requestor = InternetsRequestor.new("http://www.simon.com/blah.html?anything=1", "admin", "pass")
      requestor.stub!(:check).and_return mock(:response, :body => nil)
      request = mock("request")
      Net::HTTP.stub!(:start)
      Net::HTTP::Get.stub!(:new).and_return request
      request.should_receive(:basic_auth).with("admin", "pass")
      requestor.get
    end
    
    it "should not authenticate using basic auth if username is not provided" do
      @requestor.stub!(:check).and_return mock(:response, :body => nil)
      request = mock("request")
      Net::HTTP.stub!(:start)
      Net::HTTP::Get.stub!(:new).and_return request
      request.should_not_receive(:basic_auth)
      @requestor.get
    end
    
  end
  
end