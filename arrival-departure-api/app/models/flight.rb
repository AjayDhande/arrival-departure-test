class Flight < ApplicationRecord
  
  def self.data_today
  	flights = Flight.all
    flights.delete_all if flights.present?
    #fetch today's data
    @flights = save_flights("ankomster","ankomster", Date.today.strftime("%Y-%m-%d"))
    puts "saved - -- - -- - ankomster----at---#{Time.now}"
    @flights = save_flights("afgange","afgange", Date.today.strftime("%Y-%m-%d"))
    puts "saved - -- - -- - afgange----at---#{Time.now}"

    #fetch tommorrow's data
    after_one = URI.encode((Date.today+1.day).strftime("%d - %m - %Y"))
    @flights = save_flights("ankomster?&date=#{after_one}time=00", "ankomster",(Date.today+1.day).strftime("%Y-%m-%d"))
    @flights = save_flights("afgange?&date=#{after_one}time=00", "afgange",(Date.today+1.day).strftime("%Y-%m-%d"))
    puts "-- -- saved data for tommorrow -- -- "

    #fetch day after tommorrow's data
    after_two = URI.encode((Date.today+2.day).strftime("%d - %m - %Y"))
    @flights = save_flights("ankomster?&date=#{after_two}time=00","ankomster", (Date.today+2.day).strftime("%Y-%m-%d"))
    @flights = save_flights("afgange?&date=#{after_two}time=00", "afgange", (Date.today+2.day).strftime("%Y-%m-%d"))
    puts "-- -- saved data for day after tommorrow -- -- "
  end

   def self.save_flights(url, flight_type, date)
    require 'openssl'
		require 'open-uri'
		doc = Nokogiri::HTML(open('https://www.cph.dk/flyinformation/'+url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
		entries = doc.css('.flights__table')
		entries.css('.stylish-table__row--body').each do |record|
		  @flight  = Flight.new( flight_type: flight_type, date: date, time: record.search("span")[0].text, expected_time: record.search("span")[1].text, from: record.search("span")[6].text, number: record.search("span")[8].text, airline_company: record.search("span")[7].text, gate: record.search("span")[9].text, status: record.search("span")[11].text)  if record.search("span").count==13
      @flight  = Flight.new( flight_type: flight_type, date: date, time: record.search("span")[0].text, expected_time: "", from: record.search("span")[4].text, number: record.search("span")[6].text, airline_company: record.search("span")[5].text, gate: record.search("span")[7].text, status: record.search("span")[9].text) if record.search("span").count==11
      @flight.save
		end
    flights = Flight.all
  end
end
