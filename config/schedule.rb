set :output, "#{path}/log/cron.log"

every 12.hours do 
	rake "fetch_NASDAQ"
end

every 12.hours do 
	rake "fetch_NYSE"
end

every 12.hours do 
	rake "fetch_AMEX"
end
