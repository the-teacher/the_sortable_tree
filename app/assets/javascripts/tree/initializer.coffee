$ ->  
  # Select all trees JSON data and build it
  for data_block in $ '.render_tree'
    # Init
    data_block  = $ data_block
    klass       = data_block.find('.klass').html()
    plural      = data_block.find('.plural').html()

    # Data
    locale = JSON.parse data_block.find('.locale').html()
    tree   = JSON.parse data_block.find('.data').html()

    # Build tree
    tree_html = render_tree tree,
      klass:  klass
      plural: plural
      locale: locale

    # Append tree html after JSON data block
    tree_block = $("<div class='tree_block' />").insertAfter(data_block)
    tree_block.append "<ol class='tree'>#{tree_html}</ol>"