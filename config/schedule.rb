# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :environment, :development

env :PATH, ENV['PATH']

set :output, 'log/cron.log' #設定log的路徑

every 1.day, :at => '2:00 am' do
 # ActiveRecord::Base.connection.execute("BEGIN TRANSACTION; END;")

  rake "xmap:daily_update"
  command "echo 'Update system Xplorer map @ #{Time.now}'"
end