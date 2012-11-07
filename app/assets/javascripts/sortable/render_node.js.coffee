@render_sortable_node = (item, children, opts) ->
  children_html  = ''
  base_path      = "/#{opts.plural}/#{item.id}"
  edit_path      = "/#{opts.plural}/#{item.id}/edit"
  edit_title     = opts.locale.edit
  delete_title   = opts.locale.delete_title
  delete_confirm = opts.locale.delete_confirm
  
  # Build children
  children_html  = "<ol class='nested_set'>#{children}</ol>" if children.length > 0

  """
    <li id='#{item.id}_#{opts.klass}'>
      <div class='item'>
        <i class='handle'></i>
        <h4>
          <a href='#{base_path}'>#{item.title}</a>
        </h4>
        
        <p>#{item.content}</p>

        <div class='controls'>
          <a class='link button edit' href='#{edit_path}' title='#{edit_title}'/>
          <a class='link button delete' href='#{base_path}' data-confirm='#{delete_confirm}' data-method='delete' title='#{delete_title}'/>
        </div>
      </div>
      #{children_html}
    </li>
  """