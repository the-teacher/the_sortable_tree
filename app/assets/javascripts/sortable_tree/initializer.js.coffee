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
      $('.sortable_tree i.handle').hide()

    success: (data, status, xhr) ->
      $('.sortable_tree i.handle').show()

    error: (xhr, status, error) ->
      console.log error

$ ->
  for sortable_tree in $('ol.sortable_tree')
    sortable_tree = $ sortable_tree
    rebuild_url   = sortable_tree.data('rebuild_url')
    max_levels    = sortable_tree.data('max_levels')

    ############################################
    # Initialize Sortable Tree
    ############################################
    sortable_tree.nestedSortable
      items:            'li'
      helper:           'clone'
      handle:           'i.handle'
      tolerance:        'pointer'
      maxLevels:        max_levels
      revert:           250
      tabSize:          25
      opacity:          0.6
      placeholder:      'placeholder'
      disableNesting:   'no-nest'
      toleranceElement: '> div'
      forcePlaceholderSize: true

    ############################################
    # Sortable Update Event
    ############################################
    sortable_tree.on "sortupdate", (event, ui) =>
      item      = ui.item
      item_id   = item.attr('id')
      prev_id   = item.prev().attr('id')
      next_id   = item.next().attr('id')
      parent_id = item.parent().parent().attr('id')
      
      rebuild_sortable_tree(rebuild_url, item_id, parent_id, prev_id, next_id)