module Okezoneid
	module SSOComment
		include SSOOkezone
		mattr_accessor :api_comment_path

		self.api_comment_path = '/api/v1/comments/'

		def sso_post_comment(params)
			comment = {:body =>  {:content_id => params['content_id'],
														:okezone_id => params['okezone_id'],
														:channel_id => params['channel_id'],
														:title => params['title'],
														:date_created => params['date_created'],
														:from_name => params['from_name'],
														:request_url => params['request_url'],
														:comment => params['comment'],
														:parent_id => params['parent_id'],
														:source => params['source']}}
			

			token = sso_get_token
			response = token.post(api_comment_path, comment)
			return response.body
		end

		def sso_get_comment(params)
			comment = {:body =>  {:content_id => params['content_id'],
														:offset => params['offset'],
														:limit => params['limit']}}

			token = sso_get_token
			response = token.get(api_comment_path, comment)
			return response.body
		end

	end
end
