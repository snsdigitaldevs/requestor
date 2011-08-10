module Requestor  
  class Audit < Logger
    
    def initialize(log_file_name="audit")
      unless log_file_name.empty?
        logfile = nil
        begin
          logfile = File.open("#{RAILS_ROOT}/log/#{log_file_name}.log", 'a') if RAILS_ROOT
        rescue
          logfile = File.open("#{log_file_name}.log", 'a')
        end
        logfile.sync = true
        super logfile
      else
      end
      
    end

  end
  
end

