module Spree::RoleDecorator
  class << self
    define_method :affiliate do
      find_or_create_by(name: :affiliate)
    end
  end
end

Spree::Role.prepend Spree::RoleDecorator