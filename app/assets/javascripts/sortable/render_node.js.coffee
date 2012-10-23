@render_node = (item, children, opts) ->
  children_html = ''
  children_html = "<ol class='nested_set'>#{children}</ol>" if children.length > 0

  """
    <li id='#{item.id}_#{sortable_items_klass}'>
      <div class='item'>
        <i class='handle'></i>
        <h4>
          <a href='#'>#{item.title}</a>
        </h4>
        
        <p>#{item.content}</p>

        <div class='controls'>
          <a class='link button edit' href='#' />
          <a class='link button delete' href='#' />
        </div>
      </div>
      #{children_html}
    </li>
  """