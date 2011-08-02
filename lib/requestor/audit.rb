=begin
logger = Audit::Logster.new('junk')#will create new log called junk.log
logger.warn("message")
logger.info("message")
logger.debug("message")
logger.error("message")
logger.fatal("message")
logger.unknown("message")
=end
module Requestor  
  class Audit < Logger
    
    def initialize(log_file_name="audit", isRails=true)
      logfile = nil
      if isRails
        logfile = File.open("#{RAILS_ROOT}/log/#{log_file_name}.log", 'a')
      else
        logfile = File.open("#{log_file_name}.log", 'a')
      end
      logfile.sync = true
      super logfile
    end
    
  end
  
end

