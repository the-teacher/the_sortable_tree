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
  # console.time('tree build')
  # console.log 'tree length: ', tree.length
  # console.timeEnd('tree build')

  ############################################
  # Build Sortable Tree
  ############################################
  # Select all trees JSON data and build it
  for data_block in $ '.tree_json_data'
    data_block  = $ data_block
    klass       = data_block.find('.klass').html()
    plural      = data_block.find('.plural').html()
    rebuild_url = data_block.find('.rebuild_url').html()
    # Data
    locale = JSON.parse data_block.find('.locale').html()
    tree   = JSON.parse data_block.find('.data').html()
    
    tree_html = render_tree tree,
      klass:       klass
      plural:      plural
      locale:      locale
      rebuild_url: rebuild_url

    # Append tree html after JSON data block
    tree_block = $("<div class='tree_block' />").insertAfter(data_block)
    tree_block.append """
      <p class='sortable_new'>
        <a href='#{plural}/new'>#{locale.new_path}</a>
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