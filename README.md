# canonical_domain

Allows for rack apps to manipulate the request host into a 'canonical domain'
which is stable across the various environments the app is run in. See below
for why this could be useful.

## Use Case

Lets say you want to build a Rails app that acts differently when accessed via
different domains (such as a CMS that manages content of different sites with
the same database).

These kinds of apps are usually a pain to get up and running in development
because normally you'd just hit `http://localhost:3000` and be on your way.

But because your app is inspecting `request.host` to do different things, you'll
have to end up putting lines into your `/etc/hosts` in order to trick your app
into thinking it's running under an expected domain name:

    127.0.0.1 myapp.com

This is a bummer because then you'd have to remove those lines again every time
you want to see the real site. With canonical_domain, you could instead add this
to `/etc/hosts`:

    127.0.0.1 myapp.com.local

Along with using the middleware like so:

    use CanonicalDomain::Middleware, '', '.local'

This way, when you access your app at `myapp.com.local`, you can reference the
'canonical domain' in the rack environment:

    request.env['canonical_domain.domain'] # => 'myapp.com'

With the canonical domain stable across the different environments of your app,
you are free to use it to scope Rails routes, use production DB snapshots in
development, etc.

## Installation

Nothing fancy! Just add `gem 'canonical_domain'` to your app's Gemfile, or
install using rubygems: `gem install canonical_domain`

## Usage

### Rails

`CanonicalDomain::Middleware` is injected into your app's middleware stack
automatically.

Use `config.canonical_domain.host_prefix` and `.host_suffix` to control how the
request host is transformed into the canonical domain. These will be stripped
from the request host to generate the canonical domain, e.g:

    # config/application.rb
    config.canonical_domain.host_prefix = 'myapp.'
    config.canonical_domain.host_suffix = ''

    # config/environments/development.rb
    config.canonical_domain.host_suffix = '.local'

    # inside a controller or view:
    request.host # => 'myapp.foobar.com.local'
    request.env['canonical_domain.domain'] # => 'foobar.com'

### Other rack apps

Add CanonicalDomain::Middleware to your middleware stack with host_prefix and
_suffix parameters like so:

    Rack::Builder.new do |builder|
      builder.use CanonicalDomain::Middleware, 'myapp.', '.local'
      builder.run MyApp
    end

## Todo

- Rename to something better, ideas:
    * MultiHost
    * OmniHost
    * polygamist
    * twoface
- Come up with better words for translation between canonical and
  environment-specific hosts:
    * Mogrify
    * mangle
    * munge
    * environmentalize
    * dress / undress
    * specificalize
- Provide activemodel plugin: `has_canonical_domain :domain`, which creates
  reader method.
- Provide more flexible options for transforming the host into the request host.
- Use the [ghost](https://github.com/bjeanes/ghost) gem to automatically manage
  locally accessible domain names.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
