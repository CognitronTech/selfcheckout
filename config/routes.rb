Rails.application.routes.draw do
	mount API::Base, at: "/v1"
end
