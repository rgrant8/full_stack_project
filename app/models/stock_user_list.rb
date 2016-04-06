class StockUserList < ActiveRecord::Base
  belongs_to :lists
  belongs_to :amexes
  belongs_to :nyses
  belongs_to :users

  def self.search(search)
    	if search
      		where('name LIKE ? OR symbol LIKE ? OR sector LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    	else
      		where(nil)
    	end
  	end
end
