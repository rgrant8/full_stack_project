class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable    
  
  #validates :email, uniqueness: false
  
  def email_required?
  	false
  end

  def password_required?
    false
  end

  def self.new_guest
    new { |u| u.guest = true }
  end

  def name
  	guest ? "Guest" : email
  end

end
