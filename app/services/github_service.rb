class GithubService
  attr_accessor :access_token

  def initialize(token_hash = nil)
    if token_hash
      @access_token = token_hash["access_token"]
    end
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret, code: code}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    @access_token  = access_hash["access_token"]
  end

  def get_username
    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    @username = user_json["login"]
  end

  def get_repos
    repo_response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    repo_json = JSON.parse(repo_response.body)
    repos = repo_json
    @repos = repos.collect do |repo|
      repo = GithubRepo.new(repo)
    end
  end

  def create_repo(repo_name)
    response = Faraday.post "https://api.github.com/user/repos", {"name": repo_name}.to_json, {'Authorization': "token #{@access_token}"}
  end

end
