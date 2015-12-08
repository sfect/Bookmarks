require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module PostitTemplate
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
  end
end

config.assets.initialize_on_precompile = false