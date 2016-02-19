require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Idrochat
  class Application < Rails::Application
    # Include bower components in the assets pipeline (including bootstrap fonts)
    config.assets.paths << Rails.root.join("vendor","assets","bower_components")
  end
end
