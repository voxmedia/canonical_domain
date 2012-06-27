require 'canonical_domain/rails/route_constraint'

module CanonicalDomain
  module Rails
    class Railtie < ::Rails::Railtie
      config.canonical_domain = ActiveSupport::OrderedOptions.new({
        :host_prefix => '',
        :host_suffix => ''
      })

      initializer 'canonical_domain.insert_middleware' do |app|
        app.config.middleware.use CanonicalDomain::Middleware
      end
    end
  end
end
