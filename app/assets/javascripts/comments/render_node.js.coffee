@render_node = (item, children, opts) ->
  children_html  = ''
  t              = opts.locale
  
  # Build children
  children_html = "<ol class='nested_set'>#{children}</ol>" if children.length > 0

  """
    <li>
      <div class='comment'>
        <h4>#{item.name}</h4>
        <p>#{item.content}</p>
        <p class='reply'><a href='#'>#{t.reply}</a></p>
      </div>
      #{children_html}
    </li>
  """