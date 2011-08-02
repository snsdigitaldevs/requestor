require File.dirname(__FILE__) + '/spec_helper'

describe "Requestor::Audit" do

  describe "new" do
    
    before(:each) do
      @log = Requestor::Audit.new
      #@log = Requestor::Audit.new('mysample')
    end
    
    it "should return a logger" do
      @log.class.should == Requestor::Audit
      @log.info("test").should == true
      @log.debug("Created logger").should == true
      @log.info("Program started").should == true
      @log.warn("Nothing to do!").should == true
      @log.fatal("Ahhhhhh!").should == true
      @log.unknown("WTF?").should == true
      @log.add(Logger::FATAL) { 'Fatal error!' }.should == true
    end
  
    
  end
  
end