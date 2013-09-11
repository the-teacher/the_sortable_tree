$ = jQuery

# ----------------------------------------
# Restorable Helpers
# ----------------------------------------
@add_to_restorable_path = (node) ->
  if window.is_restorable_tree
    id = node.data('node-id')
    nested_tree_path_add(id)
    return true
  false

@remove_from_restorable_path = (node) ->
  if window.is_restorable_tree
    id = node.data('node-id')
    nested_tree_path_remove(id)
    return true
  false

# ----------------------------------------
# Main Helpers
# ----------------------------------------
@nested_tree_toggle = (button) ->
  if button.hasClass('minus')
    button.removeClass('minus').addClass('plus').html('+')
  else
    button.removeClass('plus').addClass('minus').html('&ndash;')

@append_children_to_node = (node, html) ->
  html = html.trim()
  item = node.children('.item')

  button = node.children('.item').children('.expand')

  if html.length is 0
    button.addClass 'empty'

  if html.length > 0
    item.after html
    nested_tree_toggle(button)
    add_to_restorable_path(node)

@upload_nodes_children = (node, expand_node_url) ->
  node_id    = node.data('node-id')
  tree       = $('.sortable_tree')
  ctrl_items = $('i.handle, b.expand', tree)

  $.ajax
    type:     'POST'
    dataType: 'html'
    data:     { id: node_id }
    url:      expand_node_url

    beforeSend: (xhr) ->
      ctrl_items.hide()
      window.skip_expandable_tree_hashchange = true

    success: (data, status, xhr) ->
      ctrl_items.show()
      append_children_to_node(node, data)

    error: (xhr, status, error) ->
      try
        console.log error

$.fn.extend
  init_expandable_tree: ->
    return @each () ->
      $this = $(this)

      window.is_restorable_tree         ||= false
      window.is_cookie_restoreable_tree   = $this.data('cookie_store') || $this.data('cookie-store')

      if window.is_cookie_restoreable_tree
        steps = $.cookie(TSTconst.cookie_name())
        _set_hash(TSTconst.hash_prefix() + steps) if steps

      expand_node_url = $this.data('expand_node_url') || $this.data('expand-node-url')

      # Now it's designed only for one tree
      restore_nested_tree($this, expand_node_url) if window.is_restorable_tree

      $this.on 'click', '.expand.minus', (e) ->
        button = $ @
        node   = button.parent().parent()
        nested_tree_toggle(button)
        remove_from_restorable_path(node)
        node.children('.nested_set').hide()

      $this.on 'click', '.expand.plus', (e) ->
        button     = $ @
        node       = button.parent().parent()
        nested_set = node.children('.nested_set')
        
        if nested_set.length is 0
          upload_nodes_children(node, expand_node_url)
        else
          nested_set.show()
          nested_tree_toggle(button)
          add_to_restorable_path(node)


$ -> 
  $('ol.sortable_tree').init_expandable_tree()