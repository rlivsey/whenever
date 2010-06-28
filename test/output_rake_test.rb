require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class OutputRakeTest < Test::Unit::TestCase
  
  # Rake are generated in an almost identical way to runners so we
  # only need some basic tests to ensure they are output correctly
  
  context "A rake command with path set" do
    setup do
      @output = Whenever.cron \
      <<-file
        set :path, '/my/path'
        every 2.hours do
          rake "blahblah"
        end
      file
    end
    
    should "output the rake command using that path" do
      assert_match two_hours + ' cd /my/path && RAILS_ENV=production /usr/bin/env rake blahblah', @output
    end
  end
  
  context "A rake command that overrides the path set" do
    setup do
      @output = Whenever.cron \
      <<-file
        set :path, '/my/path'
        every 2.hours do
          rake "blahblah", :path => '/some/other/path'
        end
      file
    end
    
    should "output the rake command using that path" do
      assert_match two_hours + ' cd /some/other/path && RAILS_ENV=production /usr/bin/env rake blahblah', @output
    end
  end
  
  context "A rake command with path to rake set" do
    setup do
      @output = Whenever.cron \
      <<-file
        set :path, '/my/path'      
        set :rake_path, '/path/to/rake'
        every 2.hours do
          rake "blahblah"
        end
      file
    end
    
    should "output the rake command using that path" do
      assert_match two_hours + ' cd /my/path && RAILS_ENV=production /path/to/rake blahblah', @output
    end
  end
  
  context "A rake command that overrides the path to rake" do
    setup do
      @output = Whenever.cron \
      <<-file
        set :path, '/my/path'      
        set :rake_path, '/path/to/rake'
        every 2.hours do
          rake "blahblah", :rake_path => 'bundle exec rake'
        end
      file
    end
    
    should "output the rake command using that path" do
      assert_match two_hours + ' cd /my/path && RAILS_ENV=production bundle exec rake blahblah', @output
    end    
  end
  
  context "A rake command with environment set" do
    setup do
      @output = Whenever.cron \
      <<-file
        set :environment, :silly
        set :path, '/my/path'
        every 2.hours do
          rake "blahblah"
        end
      file
    end
    
    should "output the rake command using that environment" do
      assert_match two_hours + ' cd /my/path && RAILS_ENV=silly /usr/bin/env rake blahblah', @output
    end
  end
  
  context "A rake command that overrides the environment set" do
    setup do
      @output = Whenever.cron \
      <<-file
        set :environment, :silly
        set :path, '/my/path'
        every 2.hours do
          rake "blahblah", :environment => :serious
        end
      file
    end
    
    should "output the rake command using that environment" do
      assert_match two_hours + ' cd /my/path && RAILS_ENV=serious /usr/bin/env rake blahblah', @output
    end
  end
  
end