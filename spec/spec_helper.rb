$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'jekyll-author'

ENV['JEKYLL_LOG_LEVEL'] = 'error'

CONFIG_DEFAULTS = {}.freeze

def make_site(options = {})
  config = Jekyll.configuration CONFIG_DEFAULTS.merge(options)
  Jekyll::Site.new(config)
end
