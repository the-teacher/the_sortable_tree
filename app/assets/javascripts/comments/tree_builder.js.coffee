# @render_comment_node = (item, children, opts) ->
#   t = opts.locale
#   children_html = ''
  
#   # Build children
#   children_html = "<ol class='nested_set'>#{children}</ol>" if children.length > 0

#   """
#     <li>
#       <div class='comment' data-comment-id='#{item.id}'>
#         <h4>#{item.name}</h4>
#         <p>#{_unescape(item.content)}</p>
#         <p class='reply_block'>
#           <a href='#' class='reply'>#{t.reply}</a>
#           <a href='#' class='skip' style='display:none'>#{t.skip}</a>
#         </p>
#       </div>
#       #{children_html}
#     </li>
#   """
# $ ->
#   ############################################
#   # Build Sortable Tree
#   ############################################
#   # Select all trees JSON data and build it
#   for data_block in $ '.comments_tree'
#     # Init
#     data_block  = $ data_block
#     klass       = data_block.find('.klass').html()
#     plural      = data_block.find('.plural').html()
#     rebuild_url = data_block.find('.rebuild_url').html()

#     # Data
#     t    = JSON.parse data_block.find('.locale').html()
#     tree = JSON.parse data_block.find('.data').html()

#     # Build tree
#     tree_html = render_tree tree,
#       render_node: render_comment_node
#       klass:       klass
#       plural:      plural
#       locale:      t
#       rebuild_url: rebuild_url

#     # Append tree html after JSON data block
#     tree_block = $("<div class='tree_block' />").insertAfter(data_block)
#     tree_block.append """
#       <ol class='comments'>
#         #{tree_html}
#       </ol>
#     """