class GithubService

  attr_accessor :access_token

  def initialize(hash = {})
    @access_token = hash['access_token']
  end

  def authenticate!(client_id, client_secret, code)
    if @access_token
      @access_token
    else
      response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret, code: code}, {'Accept' => 'application/json'}

      access_hash = JSON.parse(response.body)
      @access_token = access_hash["access_token"]
    end
  end

  def get_username(token)
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{token}", 'Accept' => 'application/json'}

    user_json = JSON.parse(user_response.body)
    user_json["login"]
  end

end
