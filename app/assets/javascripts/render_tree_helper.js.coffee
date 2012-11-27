@_escape = (str) ->
  str
  .replace(/&/g, '&amp;')
  .replace(/>/g, '&gt;')
  .replace(/</g, '&lt;')
  .replace(/"/g, '&quot;')

@_unescape = (str) ->
  str
  .replace(/&amp;/g, '&')
  .replace(/&gt;/g, '>')
  .replace(/&lt;/g, '<')
  .replace(/&quot;/g, '"')

@render_tree = (tree, options = {}) ->
  html = ''

  opts =
    id:    'id'
    node:  null
    root:  false
    level: 0
    boost: []

  # JQuery hash merge
  $.extend opts, options

  # Define Boost Only Once
  unless opts['boost'].length is 0
    boost = []
    for node in tree
      num  = node.parent_id || 0
      item = boost[num]
      boost[num] = [] unless item instanceof Array
      boost[num].push node

    opts['boost'] = boost

  unless opts.node
    # render root nodes
    roots = opts['boost'][0]

    # select roots
    # for node in tree
    #   roots.push node if node.parent_id is null

    # roots is empty, but tree is not empty
    # I should select nodes with minimal parent_id
    # they will be roots
    # order by lft, should be made at server side
    min_elem = tree[0]
    if roots.length is 0 and tree.length isnt 0
      for elem in tree
        min_elem = elem if elem.parent_id < min_elem.parent_id
      # select roots witn min parent_id
      for elem in tree
        if elem.parent_id is min_elem.parent_id
          roots.push elem

    # render tree
    for node in roots
      $.extend opts, { node: node, root: false, level: opts.level + 1 }
      children_html = render_tree tree, opts
      html += opts.render_node(node, children_html, opts)
  else
    # render children nodes
    children      = []
    children_html = ''
    children      = boost[opts.node.id]

    # select children
    # for elem in tree
    #   children.push elem if elem.parent_id is opts.node.id

    # render children nodes
    for node in children
      $.extend opts, { node: node, root: false, level: opts.level + 1 }
      children_html = render_tree tree, opts
      html += opts.render_node(node, children_html, opts)
  
  # result html
  html