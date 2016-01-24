module ViewLookupByModule
  extend ActiveSupport::Concern

  included do
    before_filter :add_module_prefix
  end

  def add_module_prefix
    _prefixes.unshift module_path if module_path.present?
  end

  private

  def module_path
    parent_module.to_s.underscore unless parent_module == Object
  end

  def parent_module
    self.class.parent
  end
end
