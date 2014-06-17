module TheTreeModel
  def self.included(base) # :nodoc:
    # Include either awesome_nested_set or ancestry
    base.class_eval do
      case ENV['SORTABLE_TREE_TYPE']
      when 'ancestry'
        has_ancestry
      when 'awesome_nested_set', '', nil
        acts_as_nested_set
      else
        Rails.logger.error "[TheSortableTree DummyApp] Unrecognised SORTABLE_TREE_TYPE: #{ENV['SORTABLE_TREE_TYPE']}"
      end
    end
  end
end
