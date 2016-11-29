class IndentedCollectionSelectInput < SimpleForm::Inputs::CollectionSelectInput
  def input
    label_method, value_method = detect_collection_methods
    collection.map! do |o|
      depth_method = options[:depth_method] || :depth
      spacing = (options[:spacing] || 3).to_i
      label = "\u202f" * spacing * o.send(depth_method) + o.send(label_method)
      [label, o.send(value_method)]
    end
    super
  end
end
