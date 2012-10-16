@render_node = (item, children, opts) ->
  children_html = ''
  children_html = "<ol class='nested_set'>#{children}</ol>" if children.length > 0

  """
    <li>
      <h4>#{item.title}</h4>
      <p>#{item.content}</p>
      #{children_html}
    </li>
  """