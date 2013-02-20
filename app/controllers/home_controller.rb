class HomeController < ApplicationController
  def index
  	if current_user
  		@graph = Koala::Facebook::API.new(current_user.token)
		@profile_image = @graph.get_picture("me")
		@friends_allready_on_app = @graph.get_connections("me", "friends?fields=installed").delete_if { |x| !x.has_key?("installed") }

	end
  end
end
