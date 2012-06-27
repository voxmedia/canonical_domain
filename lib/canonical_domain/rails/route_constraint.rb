# Determines whether the canonical_domain of the current request is included in
# the list of arguments, or if the return value of calling the passed block
# with the canonical_domain returns a truthy value. Examples:
#
#   CanonicalDomain::Rails::RouteConstraint.new('example.com', 'test.com')
#
#   CanonicalDomain::Rails::RouteConstraint.new do |canonical_domain|
#     Community.exists?(:domain => canonical_domain)
#   end
module CanonicalDomain
  module Rails
    class RouteConstraint
      def initialize(*list, &block)
        @list = list
        @block = block
      end

      def matches?(request)
        canonical_domain = request.env['canonical_domain.domain']
        list_matches?(canonical_domain) || block_matches?(canonical_domain)
      end

      def list_matches?(domain)
        @list.include?(domain)
      end

      def block_matches?(domain)
        @block && @block.call(domain)
      end
    end
  end
end
