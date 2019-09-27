class RepositoriesController < ApplicationController
  def index
    @repos_array = GithubService.new.repos(session[:token])
  end

  def create
    GithubService.new.create_repo(session[:token], params[:name])
    redirect_to '/'
  end
end
