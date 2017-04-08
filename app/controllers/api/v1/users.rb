module API  
	module V1
	  	class Users < Grape::API

	  		  format :json
    		  prefix :api

	     	resource :users do
	     		desc 'Register endpoint.'
		     	post :register do
		  		   user = User.new(email: params[:email],password: params[:password])
		  		   p user.valid?
		  		   p user.email
		            if user.valid?
		              user.save
		              return user
		            else
		              error!({:error_code => 404, :error_message => "Invalid email or password."}, 401)
		            end
	            end
			    desc 'Login endpoint.'
			    post :login do
			    	  email = params[:email]
			          password = params[:password]
			          if email.nil? or password.nil?
			            error!({:error_code => 404, :error_message => "Enter email or password."}, 401)
			            return
			          end

			          user = User.find_by(email: email.downcase)
			          if user.nil?
			             error!({:error_code => 404, :error_message => "Invalid email or password1."}, 401)
			             return
			          end

			          if !user.valid_password?(password)
			             error!({:error_code => 404, :error_message => "Invalid email or password2."}, 401)
			             return
			          else
			            user.ensure_authentication_token!
			            user.save
			            status(201)
			            {status: 'ok', token: user.authentication_token }
			          end
	     		end
     		end
		end
	end
end
