# maybye, make some module for includes and configs
# require ::File.expand_path('../config/environment',  __FILE__)

class Application < Sinatra::Base
	# initialize new sprockets environment
	set :environment, Sprockets::Environment.new

	# append assets paths
	environment.append_path "assets/stylesheets"
	environment.append_path "assets/javascripts"

	# compress assets
	# js_compression  :jsmin    # :jsmin | :yui | :closure | :uglify
	environment.js_compressor  = Uglifier.new(mangle: false)
	environment.css_compressor = :scss

	# config.assets.js_compressor = Uglifier.new(mangle: false)

	get '/assets/*' do
		env['PATH_INFO'].sub!('/assets', '')
		settings.environment.call(env)
	end

	get '/' do
		haml :index
	end

	get '/birds' do
		haml :birds
	end

	get '/game' do
		haml :game, layout: :angular_layout
	end

	get '/test' do
		haml :test, layout: false
	end

	get '/example_jbox' do
		haml :example_jbox
	end

	get '/example soundbox' do
		haml :example_soundbox
	end
end