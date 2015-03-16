module Okezoneid
	module SSOUser
		include SSOOkezone

		mattr_accessor :api_user_path

		self.api_user_path = '/api/v1/okezone_id/'

		def sso_user_detail_by_id(id)
			token = sso_get_token
			response = token.get(api_user_path + 'detail/id/'+ id.to_s)
			return response.parsed
		end

		def sso_user_detail_by_username(username)
			token = sso_get_token
			response = token.get(api_user_path + 'detail/username/'+ username.to_s)
			return response.parsed
		end

		def sso_user_detail_by_okezone_id(okezone_id)
			token = sso_get_token
			response = token.get(api_user_path + 'detail/okezone_id/'+ okezone_id.to_s)
			return response.parsed
		end

		def sso_current_user
			token = sso_get_token
			response = token.get(api_user_path + 'detail/current_user')
			return response.parsed
		end

	end
end