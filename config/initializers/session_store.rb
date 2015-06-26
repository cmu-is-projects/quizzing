# Be sure to restart your server when you modify this file.

Quizzing::Application.config.session_store :cookie_store, domain: :all, tld_length: 2, key: SETTINGS[:session_name]
