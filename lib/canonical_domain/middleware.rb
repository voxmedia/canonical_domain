module CanonicalDomain
  class Middleware
    def initialize(app, prefix = nil, suffix = nil)
      @app = app
      @prefix = prefix
      @suffix = suffix
    end

    def prefix
      @prefix || rails_config('host_prefix')
    end

    def suffix
      @prefix || rails_config('host_suffix')
    end

    def call(env)
      env['canonical_domain.domain'] = Rack::Request.new(env).host.tap do |host|
        host.sub! /^#{prefix}/, ''
        host.sub! /#{suffix}$/, ''
      end

      @app.call(env)
    end

    private

    def rails_config(key)
      defined?(::Rails) && ::Rails.configuration.canonical_domain[key]
    end
  end
end
