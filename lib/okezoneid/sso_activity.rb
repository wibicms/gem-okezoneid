module Okezoneid
	module SSOActivity
		include SSOOkezone
		mattr_accessor :api_activity_path

		self.api_activity_path = '/api/v1/activities/'

		def sso_post_activity(params)
			activity = {:body => {:request_url => params['request_url'],
								  :okezone_id => params['okezone_id'],
								  :ip_address => request.remote_ip,
								  :browser => request.user_agent,
								  :log_type => params['log_type'],
								  :refferer => params['refferer'],
								  :author => params['author'],
								  :editor => params['editor'],
								  :published => params['published']}}
			token = sso_get_token
			response = token.post(api_activity_path, activity)
			return response.body
		end
	end
end
