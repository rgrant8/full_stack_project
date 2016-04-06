class Nyse < ActiveRecord::Base
	def self.search(search)
    	if search
      		where('name LIKE ? OR symbol LIKE ? OR sector LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    	else
      		where(nil)
    	end
  	end
end
