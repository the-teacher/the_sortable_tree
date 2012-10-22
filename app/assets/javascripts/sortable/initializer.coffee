@rebuild_sortable_tree = (item_id, parent_id, prev_id, next_id) ->
  $.ajax
    type:     'POST'
    dataType: 'script'
    url:      sortable_rebuild_url
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
    data_block = $ data_block
    tree       = JSON.parse data_block.html()
    tree_html  = render_tree(tree)

    # Append tree html after JSON data block
    data_block.after "<ol class='sortable'>#{tree_html}</ol>"

  ############################################
  # Initialize Sortable Tree
  ############################################
  $('ol.sortable').nestedSortable
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
  # Sortable Update Event
  ############################################
  $('ol.sortable').sortable
    update: (event, ui) =>
      item      = ui.item
      item_id   = item.attr('id')
      prev_id   = item.prev().attr('id')
      next_id   = item.next().attr('id')
      parent_id = item.parent().parent().attr('id')
      
      rebuild_sortable_tree(item_id, parent_id, prev_id, next_id)