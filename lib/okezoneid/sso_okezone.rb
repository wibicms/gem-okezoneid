module V1
  module  SSOOkezone
    require 'oauth2'
    mattr_accessor :client_id, :secret_id, :auth_server, :redirect_uri

    self.client_id = "b874a1c99cf91eda04383c2df3dca56a66a341a0e67b9b899f2c3fa64daa5af6"
    self.secret_id = "b87e5a9e8a13ffb2ca64c6a51599d751041fedd23ba029752b299d41fe35f18a"
    self.auth_server = "http://ssodev.okezone.com"
    self.redirect_uri = "http://demo.okezone.com:4000/login"

    def sso_iframe_checker
      current_url = redirect_uri
      return auth_server+'/checker?uri_callback=' + current_url
    end

    def sso_is_login
      current_token = get_access_token
      current_status = get_access_status
      if current_token == nil ||  current_status == nil || current_status == 0
        return false
      else
        return true
      end

    end

    def sso_login
      client = sso_set_client
      return client.auth_code.authorize_url(:redirect_uri => redirect_uri)
    end

    def sso_logout
      session[:sso_token]
    end

    def sso_get_token
      token = sso_build_token
      token = OAuth2::AccessToken.from_hash(sso_set_client, token)
      return token
    end

    def sso_set_token(code)
      code = sso_set_code(code)
      client = sso_set_client
      token = client.auth_code.get_token(code, :redirect_uri => redirect_uri, :headers => {'Authorization' => 'Bearer %code'})
      session[:sso_token] = token.to_hash
      session[:sso_expire] = token.expires_at
      set_access_token(token.token)
      set_access_status(1)
    end

    def sso_set_token_param(token_id)
      set_access_token(token_id)
      set_access_status(1)
    end


    private

    def sso_set_client
      return OAuth2::Client.new(client_id, secret_id, :site => auth_server)
    end

    def sso_set_code (code)
      session[:sso_code] = code
    end

    def sso_get_code
      code = session[:sso_code]
      return code
    end

    def sso_build_token
      current_session = session[:sso_token]
      if current_session == nil
        current_session = Hash.new
      end
      if current_session['access_token']==nil
        current_session['access_token'] = get_access_token
        current_session['expires_at'] = session[:sso_expire]
      end

      return current_session
    end

    def set_access_token(access_token)
      cookies[:IDACCESS] = {
          value: access_token,
          domain: :all
      }
    end

    def set_access_status(status)
      cookies[:IDSTATUS] = {
          value: status,
          domain: :all
      }
    end

    def get_access_token
      return cookies[:IDACCESS]
    end

    def get_access_status
      return cookies[:IDSTATUS]
    end
  end
end