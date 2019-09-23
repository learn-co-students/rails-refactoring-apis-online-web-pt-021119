class RepositoriesController < ApplicationController
  def index
    repos = GithubService.new({"access_token" => session[:token]})
    @repos_array = repos.get_repos
  end

  def create
    repo = GithubService.new({"access_token" => session[:token]})
    new_repo = repo.create_repo(params[:name])

    redirect_to '/'
  end
end
