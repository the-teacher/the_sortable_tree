@render_comment_node = (item, children, opts) ->
  t = opts.locale
  children_html = ''
  
  # Build children
  children_html = "<ol class='nested_set'>#{children}</ol>" if children.length > 0

  """
    <li>
      <div class='comment' data-comment-id='#{item.id}'>
        <h4>#{item.name}</h4>
        <p>#{_unescape(item.content)}</p>
        <p class='reply_block'>
          <a href='#' class='reply'>#{t.reply}</a>
          <a href='#' class='skip' style='display:none'>#{t.skip}</a>
        </p>
      </div>
      #{children_html}
    </li>
  """