require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module LearningOnline
  class Application < Rails::Application
    config.load_defaults 6.0
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag.html_safe }
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
  end
end
