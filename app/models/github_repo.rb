class GithubRepo
	attr_accessor :name, :url

	@@all = []

	def initialize(attribs)
		@name = attribs['name']
		@url = attribs['html_url']
		@@all << self unless !@name
	end

	def self.all
		@@all.uniq
	end

end