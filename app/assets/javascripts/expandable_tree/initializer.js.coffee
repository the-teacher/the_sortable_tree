@append_children_to_node = (node, html) ->
  html = html.trim()
  item = node.children('.item')

  button = node.children('.item').children('.expand')

  if html.length is 0
    button.addClass 'empty'

  if html.length > 0
    button.removeClass('plus').addClass('minus').html('&ndash;')
    item.after html
    

@upload_nodes_children = (node, expand_node_url, tree_type = 'expandable') ->
  node_id = node.attr 'id'

  $.ajax
    type:     'POST'
    dataType: 'html'
    url:      expand_node_url
    data:
      id: node_id
      tree_type: tree_type

    beforeSend: (xhr) ->
      $('.sortable_tree i.handle').hide()
      $('.sortable_tree b.expand').hide()

    success: (data, status, xhr) ->
      $('.sortable_tree i.handle').show()
      $('.sortable_tree b.expand').show()
      append_children_to_node(node, data)

    error: (xhr, status, error) ->
      console.log error

$ ->
  for sortable_tree in $('ol.sortable_tree')
    sortable_tree   = $ sortable_tree
    expand_node_url = sortable_tree.data('expand_node_url')
    tree_type       = sortable_tree.data('tree_type')

    pluses = $ '.expand.plus', sortable_tree

    pluses.live 'click', (e) ->
      node = $(@).parent().parent()
      upload_nodes_children(node, expand_node_url, tree_type)

      false