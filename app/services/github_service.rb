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

  def get_username
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}

    user_json = JSON.parse(user_response.body)
    user_json["login"]
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}

    res = JSON.parse(response.body)
    res_arr = res.collect { |r| GithubRepo.new(r) }
  end

  def create_repo(name)
    response = Faraday.post "https://api.github.com/user/repos", {name: name}.to_json, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
  end

end
