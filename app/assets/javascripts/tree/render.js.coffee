@render_tree_node = (item) ->
  """
    <div>
      <h4>#{item.title}</h4>
      <p>#{item.content}</p>
    </div>
  """

@render_tree = ->
  for data_block in $ '.tree_json_data'
    _nodes      = ''
    data_block = $ data_block
    nodes      = JSON.parse data_block.html()
    
    for node in nodes
      _nodes += render_tree_node(node)

    data_block.after "<div class='tree'>#{_nodes}</div>"