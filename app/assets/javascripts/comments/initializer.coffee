$ ->
  ############################################
  # Build Sortable Tree
  ############################################
  # Select all trees JSON data and build it
  for data_block in $ '.comments_tree'
    # Init
    data_block  = $ data_block
    klass       = data_block.find('.klass').html()
    plural      = data_block.find('.plural').html()
    rebuild_url = data_block.find('.rebuild_url').html()

    # Data
    locale = JSON.parse data_block.find('.locale').html()
    tree   = JSON.parse data_block.find('.data').html()

    # console.log 'tree length: ', tree.length

    # Build tree
    tree_html = render_tree tree,
      klass:       klass
      plural:      plural
      locale:      locale
      rebuild_url: rebuild_url

    # Append tree html after JSON data block
    tree_block = $("<div class='tree_block' />").insertAfter(data_block)
    tree_block.append """
      <p class='comments_new'>
        <a href='/#{plural}/new'>#{locale.new_path}</a>
      </p>
      <ol class='comments'>
        #{tree_html}
      </ol>
    """