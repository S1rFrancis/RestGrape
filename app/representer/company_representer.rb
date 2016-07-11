require 'representable/json'

class CompanyRepresenter < Representable::Decorator
  include Representable::JSON

  property :name
end
