class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    github = GithubService.new
    git_token = github.authenticate!(client_id, client_secret, params[:code])
    session[:token] = git_token

    @username = github.get_username(git_token)
    session[:username] = @username

    redirect_to '/'
  end
end
