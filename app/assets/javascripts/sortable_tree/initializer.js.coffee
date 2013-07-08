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

@init_sortable_tree = ->
  sortable_tree = $('ol.sortable_tree')
  return false if sortable_tree.length is 0
  
  rebuild_url = sortable_tree.data('rebuild_url') || sortable_tree.data('rebuild-url')
  max_levels  = sortable_tree.data('max_levels')  || sortable_tree.data('max-levels')

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
    attr_name = 'node-id'
    item_id   = item.data(attr_name)
    prev_id   = item.prev().data(attr_name)
    next_id   = item.next().data(attr_name)
    parent_id = item.parent().parent().data(attr_name)
    
    rebuild_sortable_tree(rebuild_url, item_id, parent_id, prev_id, next_id)

  true

$ -> init_sortable_tree()