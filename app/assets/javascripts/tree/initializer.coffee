$ ->
  # Benchmark:
  # 3 level deep
  # 25 nodes per level
  # 5000 nodes in tree
  # Server rendering: 1514.2ms
  # Client rendering: 406ms

  # Benchmark:
  # 3 level deep
  # 25 nodes per level
  # 16275 nodes in tree
  # Server rendering: 4906.3ms
  # Client rendering: 3056ms

  # Select all trees JSON data and build it
  for data_block in $ '.render_tree'
    # console.time('tree build')
    
    # Init
    data_block  = $ data_block
    klass       = data_block.data 'klass'
    plural      = data_block.data 'plural'
    tree        = JSON.parse data_block.html()

    # console.log 'tree length: ', tree.length

    # Build tree
    tree_html = render_tree tree,
      render_node: render_tree_node
      klass:  klass
      plural: plural

    # Append tree html after JSON data block
    tree_block = $("<div class='tree_block' />").insertAfter(data_block)
    tree_block.append "<ol class='tree'>#{tree_html}</ol>"

    # console.timeEnd('tree build')