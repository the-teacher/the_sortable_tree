@render_tree_node = (item, children, opts) ->
  children_html = ''
  show_path     = "/#{opts.plural}/#{item.id}"

  # Build children
  children_html = "<ol class='nested_set'>#{children}</ol>" if children.length > 0

  """
    <li>
      <div class='item'>
      <h4><a href='#{show_path}'>#{item.title}</a></h4>
      <p>#{item.content}</p>
      </div>
      #{children_html}
    </li>
  """