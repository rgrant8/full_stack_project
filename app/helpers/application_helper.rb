module ApplicationHelper
#=begin	
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class} 
	end
#=end

	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def current_page(path)
    	        "active" if current_page?(path) 
	end

	def user_sign_in
		if user_sign_in?
			render 'devise/menu/login_items'
		else
			render 'devise/menu/registration_items'
		end
	end

end
