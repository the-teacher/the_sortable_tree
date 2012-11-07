@rebuild_sortable_tree = (rebuild_url, item_id, parent_id, prev_id, next_id) ->
  $.ajax
    type:     'POST'
    dataType: 'script'
    url:      rebuild_url
    data:
      id:        item_id
      parent_id: parent_id
      prev_id:   prev_id
      next_id:   next_id

    beforeSend: (xhr) ->
      $('.nested_set i.handle').hide()

    success: (data, status, xhr) ->
      $('.nested_set i.handle').show()

    error: (xhr, status, error) ->
      console.log error

$ ->
  # Benchmark:
  # 3 level deep
  # 10 nodes per level
  # ~1000 nodes in tree
  # 415 ms
  # drag&drop sorting works fine

  # Benchmark:
  # 3 level deep
  # 10 nodes per level
  # 5000 nodes in tree
  # ~2000 ms
  # drag&drop sorting - very slow ~ 10sec

  # Benchmark:
  # 3 level deep
  # 25 nodes per level
  # 16275 nodes in tree
  # Server rendering: 5065.1ms
  # Client rendering: 10263ms
  # drag&drop sorting - very very slow ~ 30-40sec

  # console.time('tree build')

  ############################################
  # Build Sortable Tree
  ############################################
  # Select all trees JSON data and build it
  for data_block in $ '.sortable_tree'
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
      render_node: render_sortable_node
      klass:       klass
      plural:      plural
      locale:      locale
      rebuild_url: rebuild_url

    # Append tree html after JSON data block
    tree_block = $("<div class='tree_block' />").insertAfter(data_block)
    tree_block.append """
      <p class='sortable_new'>
        <a href='/#{plural}/new'>#{locale.new_path}</a>
      </p>
      <ol class='sortable'>
        #{tree_html}
      </ol>
    """

    ############################################
    # Initialize Sortable Tree for this block
    ############################################
    $('ol.sortable', tree_block).nestedSortable
      items:            'li'
      helper:           'clone'
      handle:           'i.handle'
      tolerance:        'pointer'
      maxLevels:        3
      revert:           250
      tabSize:          25
      opacity:          .6
      placeholder:      'placeholder'
      disableNesting:   'no-nest'
      toleranceElement: '> div'
      forcePlaceholderSize: true

    ############################################
    # Sortable Update Event for this block
    ############################################
    $('ol.sortable', tree_block).sortable
      update: (event, ui) =>
        item      = ui.item
        item_id   = item.attr('id')
        prev_id   = item.prev().attr('id')
        next_id   = item.next().attr('id')
        parent_id = item.parent().parent().attr('id')
        
        rebuild_sortable_tree(rebuild_url, item_id, parent_id, prev_id, next_id)

  # console.timeEnd('tree build')