set :output, "#{Rails.root}/log/cron_log.log"

every 3.minutes do
  runner "Flight.data_today"
end