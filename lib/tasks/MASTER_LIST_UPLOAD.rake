desc "Fetch ALL three major Tables Information"

task :fetch_all => :environment do
	require 'nokogiri'
	require 'open-uri'
	require 'csv'
	List.connection
	Amex.connection
	Nyse.connection
	$page = 1
	$count = 0
	$not_in = 0
	$current_list = Array.new 
	$todays_list = Array.new

	List.all.each do |list|
 		list.symbol.gsub! /\r/, ''
        list.symbol.gsub! /\n/, ''
        list.symbol.gsub! /\t/, ''
        list.symbol.gsub! /\s+/, ""
 		
 		$current_list.push("#{list.symbol}")
 	end	

	CSV.open("NASDAQ.csv", "wb") do |csv|
	#csv << ["symbol","name","market","country","ipo","sector"]
	#List.find_all_by_symbol(nil).each do |list|
	    $url = "http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ"
	    $doc = Nokogiri::HTML(open($url))

	    $totNasdaq = (($doc.at_css("b:nth-child(2)").text).to_f/50).ceil
	    $lastPageTot = (($doc.at_css("b:nth-child(2)").text).to_f%50)
		
		
#=begin
	    while $page <= $totNasdaq do
	    #while $page <= 6 do	
	        $i = 2
	        $num = 100

	        #To account for the last page having less than 50
	        if $page == $totNasdaq
	        	then $num = ($lastPageTot*2)
	        end 

	        	#To change the URL to the pages# form for incrementation
	            if $page > 1
	                $url = "http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ&page=#$page"
	                $doc = Nokogiri::HTML(open($url))
	            end 
	               
	                while $i <= $num do  
	                    $symbol = $doc.at_css("tr:nth-child(#$i) h3 a").text
	                    $name = $doc.at_css("tr:nth-child(#$i) td").text 
	                    $market = $doc.at_css("tr:nth-child(#$i) td:nth-child(3)").text 
	                    $country = $doc.at_css("tr:nth-child(#$i) td:nth-child(5)").text 
	                    $ipo = $doc.at_css("tr:nth-child(#$i) td:nth-child(6)").text 
	                    $sector = $doc.at_css("tr:nth-child(#$i) td:nth-child(7)").text
	                    
	                    $i += 2
                        $symbol.gsub! /\r/, ''
                        $symbol.gsub! /\n/, ''
                        $symbol.gsub! /\t/, ''
                        $symbol.gsub! /\s+/, ""
                        	#$new_symbol = $symbol.strip.downcase

                        csv << ["#$symbol","#$name","#$market","#$country","#$ipo","#$sector"]
					 	if $symbol.in?($current_list)
				 			#puts "#{list.symbol}"
				 			$count += 1
				 		else
				 			#puts "Not in List: '#{$tester}'"
				 			#puts $symbol
				 			$not_in += 1
				 			
				 			if $symbol.size < 5
				 			list = List.new
				 				list.symbol = $symbol
				 				list.name = $name
				 				list.market = $market
				 				list.country = $country
				 				list.ipo = $ipo
				 				list.sector = $sector
				 				list.alive = true
				 				list.list_type = "NASDAQ"
				 				list.save
				 			end
				 		end
				 		$todays_list.push("#{$symbol}")
	                end
	        $page += 1
		 end
end	

puts " "
puts " * NASDAQ *"

print $lastPageTot
puts " :Objects on last page"

print $totNasdaq
puts " :Total number of pages"

print $todays_list.length
puts " :PARSED TODAY"

=begin





=end

$page = 1
	$count = 0
	$not_in = 0
	$current_list = Array.new 
	$todays_list = Array.new

	Nyse.all.each do |list|
 		list.symbol.gsub! /\r/, ''
        list.symbol.gsub! /\n/, ''
        list.symbol.gsub! /\t/, ''
        list.symbol.gsub! /\s+/, ""
 		
 		$current_list.push("#{list.symbol}")
 	end	

	CSV.open("NYSE.csv", "wb") do |csv|
	#csv << ["symbol","name","market","country","ipo","sector"]
	#List.find_all_by_symbol(nil).each do |list|
	    $url = "http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NYSE"
	    $doc = Nokogiri::HTML(open($url))

	    $totNasdaq = (($doc.at_css("b:nth-child(2)").text).to_f/50).ceil
	    $lastPageTot = (($doc.at_css("b:nth-child(2)").text).to_f%50)
		
		
#=begin
	    while $page <= $totNasdaq do
	    #while $page <= 6 do	
	        $i = 2
	        $num = 100

	        #To account for the last page having less than 50
	        if $page == $totNasdaq
	        	then $num = ($lastPageTot*2)
	        end 

	        	#To change the URL to the pages# form for incrementation
	            if $page > 1
	                $url = "http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NYSE&page=#$page"
	                $doc = Nokogiri::HTML(open($url))
	            end 
	                
	                while $i <= $num do  
	                    $symbol = $doc.at_css("tr:nth-child(#$i) h3 a").text
	                    $name = $doc.at_css("tr:nth-child(#$i) td").text 
	                    $market = $doc.at_css("tr:nth-child(#$i) td:nth-child(3)").text 
	                    $country = $doc.at_css("tr:nth-child(#$i) td:nth-child(5)").text 
	                    $ipo = $doc.at_css("tr:nth-child(#$i) td:nth-child(6)").text 
	                    $sector = $doc.at_css("tr:nth-child(#$i) td:nth-child(7)").text
	                    $list_type = "AMEX"

	                    $i += 2
                        $symbol.gsub! /\r/, ''
                        $symbol.gsub! /\n/, ''
                        $symbol.gsub! /\t/, ''
                        $symbol.gsub! /\s+/, ""
                        	#$new_symbol = $symbol.strip.downcase

                        csv << ["#$symbol","#$name","#$market","#$country","#$ipo","#$sector","#$list_type"]
					 	if $symbol.in?($current_list)
				 			#puts "#{list.symbol}"
				 			$count += 1
				 		else
				 			#puts "Not in List: '#{$tester}'"
				 			#puts $symbol
				 			$not_in += 1
				 			
				 			if $symbol.size < 5
				 			list = Nyse.new
				 				list.symbol = $symbol
				 				list.name = $name
				 				list.market = $market
				 				list.country = $country
				 				list.ipo = $ipo
				 				list.sector = $sector
				 				list.alive = true
				 				list.list_type = "NYSE"
				 				list.save
				 			end
				 		end
				 		$todays_list.push("#{$symbol}")
	                end
	        $page += 1
		 end
end	

puts " "
puts " * NYSE *"

print $lastPageTot
puts " :Objects on last page"

print $totNasdaq
puts " :Total number of pages"

print $todays_list.length
puts " :PARSED TODAY"

=begin






=end

$page = 1
	$count = 0
	$not_in = 0
	$current_list = Array.new 
	$todays_list = Array.new

	Amex.all.each do |list|
 		list.symbol.gsub! /\r/, ''
        list.symbol.gsub! /\n/, ''
        list.symbol.gsub! /\t/, ''
        list.symbol.gsub! /\s+/, ""
 		
 		$current_list.push("#{list.symbol}")
 	end	

	CSV.open("AMEX.csv", "wb") do |csv|
	#csv << ["symbol","name","market","country","ipo","sector"]
	#List.find_all_by_symbol(nil).each do |list|
	    $url = "http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=AMEX"
	    $doc = Nokogiri::HTML(open($url))

	    $totNasdaq = (($doc.at_css("b:nth-child(2)").text).to_f/50).ceil
	    $lastPageTot = (($doc.at_css("b:nth-child(2)").text).to_f%50)
		
		
#=begin
	    while $page <= $totNasdaq do
	    #while $page <= 6 do	
	        $i = 2
	        $num = 100

	        #To account for the last page having less than 50
	        if $page == $totNasdaq
	        	then $num = ($lastPageTot*2)
	        end 

	        	#To change the URL to the pages# form for incrementation
	            if $page > 1
	                $url = "http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=AMEX&page=#$page"
	                $doc = Nokogiri::HTML(open($url))
	            end 
	                
	                while $i <= $num do  
	                    $symbol = $doc.at_css("tr:nth-child(#$i) h3 a").text
	                    $name = $doc.at_css("tr:nth-child(#$i) td").text 
	                    $market = $doc.at_css("tr:nth-child(#$i) td:nth-child(3)").text 
	                    $country = $doc.at_css("tr:nth-child(#$i) td:nth-child(5)").text 
	                    $ipo = $doc.at_css("tr:nth-child(#$i) td:nth-child(6)").text 
	                    $sector = $doc.at_css("tr:nth-child(#$i) td:nth-child(7)").text
	                    $list_type = "AMEX"

	                    $i += 2
                        $symbol.gsub! /\r/, ''
                        $symbol.gsub! /\n/, ''
                        $symbol.gsub! /\t/, ''
                        $symbol.gsub! /\s+/, ""
                        	#$new_symbol = $symbol.strip.downcase

                        csv << ["#$symbol","#$name","#$market","#$country","#$ipo","#$sector","#$list_type"]
					 	if $symbol.in?($current_list)
				 			#puts "#{list.symbol}"
				 			$count += 1
				 		else
				 			#puts "Not in List: '#{$tester}'"
				 			#puts $symbol
				 			$not_in += 1
				 			
				 			if $symbol.size < 5
				 			list = Amex.new
				 				list.symbol = $symbol
				 				list.name = $name
				 				list.market = $market
				 				list.country = $country
				 				list.ipo = $ipo
				 				list.sector = $sector
				 				list.alive = true
				 				list.list_type = "AMEX"
				 				list.save
				 			end
				 		end
				 		$todays_list.push("#{$symbol}")
	                end
	        $page += 1
		 end
end	

puts " "
puts " * AMEX *"

print $lastPageTot
puts " :Objects on last page"

print $totNasdaq
puts " :Total number of pages"

print $todays_list.length
puts " :PARSED TODAY"

puts " "
puts " * SUMMARY *"
print $current_list.length
puts " :ITEMS IN DB"

end
