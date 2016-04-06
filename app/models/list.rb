class List < ActiveRecord::Base

# has_many :stock_user_lists
# accepts_nested_attributes_for :stock_user_lists
	
	def self.import(file)
       CSV.foreach(file.path, headers: true) do |row|
       List.create! row.to_hash 
       end
    end

    def self.search(search)
    	if search
      		where('name LIKE ? OR symbol LIKE ? OR sector LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    	else
      		where(nil)
    	end
  	end
end