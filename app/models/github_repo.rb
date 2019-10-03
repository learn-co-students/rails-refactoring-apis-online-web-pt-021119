class GithubRepo
  attr_accessor :name, :url

  def initialize(hash)
    # binding.pry
    if hash
      @name = hash["name"]
      @url = hash["html_url"]
    end
  end


end
