module Whenever
  module Job
    class Default
      
      attr_accessor :task, :at, :output, :output_redirection, :rake_path
    
      def initialize(options = {})
        @task               = options[:task]
        @at                 = options[:at]
        @output_redirection = options.has_key?(:output) ? options[:output] : :not_set
        @environment        = options[:environment] || :production
        @path               = options[:path] || Whenever.path
        @rake_path          = options[:rake_path] || "/usr/bin/env rake"
      end
    
      def output
        task
      end
      
    protected
      
      def path_required
        raise ArgumentError, "No path available; set :path, '/your/path' in your schedule file" if @path.blank?
      end
      
    end
  end
end