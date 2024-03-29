require File.expand_path('../boot', __FILE__)

require 'rails/all'
require_relative '../lib/helpers/team_scoring.rb'
require_relative '../lib/helpers/individual_scoring.rb'
require_relative '../lib/helpers/validations.rb'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Moving configuration settings to a separate hash available throughout the application
SETTINGS = YAML.load(File.read(File.expand_path('../settings.yml', __FILE__)))
SETTINGS.merge! SETTINGS.fetch(Rails.env, {})
SETTINGS.symbolize_keys!

module Quizzing
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += Dir["#{config.root}/lib/**/"]  # include all subdirectories
    config.autoload_paths += Dir["#{config.root}/app/workers/**/"] #include workers
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.enforce_available_locales = true

  end
end
