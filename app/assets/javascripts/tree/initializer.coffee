$ ->    
  # console.time('tree build')
  # console.log 'tree length:', tree.length
  # console.timeEnd('tree build')
  
  # Select all trees JSON data and build it
  for data_block in $ '.tree_json_data'
    data_block  = $ data_block
    klass       = data_block.find('.klass').html()
    plural      = data_block.find('.plural').html()
    # Data
    locale = JSON.parse data_block.find('.locale').html()
    tree   = JSON.parse data_block.find('.data').html()
    
    tree_html = render_tree tree,
      klass:       klass
      plural:      plural
      locale:      locale

    # Append tree html after JSON data block
    tree_block = $("<div class='tree_block' />").insertAfter(data_block)
    tree_block.append """
      <ol class='tree'>#{tree_html}</ol>
    """