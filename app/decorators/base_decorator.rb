class BaseDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  class PaginatingDecorator < Draper::CollectionDecorator
    delegate :current_page, :total_pages, :limit_value, :entry_name, :total_count, :offset_value, :last_page?
  end

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
