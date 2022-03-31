require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Microblog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_job.queue_adapter = :sidekiq

    # Sidekiq requires you to define the queues to process when it starts. You do this by listing the queue names in
    # `config/sidekiq.yml' or using the `-q` argument in order of priority:
    # `bundle exec sidekiq -q critical -q high -q default -q low`
    # Sidekiq reccomend not queueing by functionality (e.g. `mailers`, `active_storage`, `feeds`, etc), but just by
    # priority.
    #
    # We don't know in Microblog what the queuing needs of any app will be, but we do want to just set the outbound
    # emails to go into the `default` queue to avoid extra configuration

    config.action_mailer.deliver_later_queue_name = "default"

    # Setup generators to generate RSpec files instead of MiniTest and not to generate routes, assets, scaffold
    # stylesheets or helpers by default.
    config.generators do |g|
      g.assets false
      g.test_framework :rspec, 
        view_specs: false
      g.resource_route false
      g.scaffold_stylesheet false
      g.helper false
    end
  end
end
