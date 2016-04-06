class WatchlistController < ApplicationController
 before_filter :ensure_trailing_slash, :only => :index  
end

