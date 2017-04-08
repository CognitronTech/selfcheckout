module API
	module V1
	  	class Products < API::V1::Base
	  		format :json
    		prefix :api 

        helpers API::V1::Helpers::AuthenticationHelpers
    		
        resource :products do
          
          desc 'Get the list of all the products'
          get :list do
            products.all
      		end

          get :product do  
             product = Product.find_by_barcode(params[:barcode])
          end
        end

    	end
    end
end