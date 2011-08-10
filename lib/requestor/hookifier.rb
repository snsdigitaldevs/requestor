module Requestor
  module Hookifier
  
    def self.included(klass)
      klass.extend ::Requestor::Hookifier::ClassMethods
    end
  
    module ClassMethods

        # Takes a splat of method names, and wraps them with "wrap_hooks_around_it".
        def hooked_methods(*methods)
          methods.each do |meth|
            m = instance_method meth
            define_method meth do |*args|
              wrap_hooks_around_it m.bind(self), *args
            end
          end
        end
    end
  
  
    def wrap_hooks_around_it(method, *args)
      before_hooks  = self.methods.grep(/^before_handle/).sort
      after_hooks   = self.methods.grep(/^after_handle/).sort
      failure_hooks = self.methods.grep(/^on_failure/).sort
    
      begin
        begin
         before_hooks.each do |hook|
           self.send(hook, *args)
         end
        rescue Exception => e
         #Exit gracefully? p "#{e}"
         #return false
        end
      
        #do stuff here
        response = method[*args]

        #if exception are raise while "doing", these hooks will never run.
        begin
          after_hooks.each do |hook|
             self.send(hook, *args)
           end
         rescue Exception => e
          #Exit gracefully? p "#{e}"
          #return false
         end
      
       response

       # If an exception occurs during the execution, look for an
       # on_failure hook then re-raise.
       rescue Object => e
         failure_hooks.each { |hook| self.send(hook, e, *args) }
         raise e
       end
    
    end
  end
end