module Api
  class BooksController < BaseController
    include Concerns::ResourceController

    self.resource_scope = ::Book
  end
end
