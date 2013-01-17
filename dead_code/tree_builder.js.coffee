# @render_sortable_node = (item, children, opts) ->
#   children_html  = ''
#   base_path      = "/#{opts.plural}/#{item.id}"
#   edit_path      = "/#{opts.plural}/#{item.id}/edit"
#   edit_title     = opts.locale.edit
#   delete_title   = opts.locale.delete_title
#   delete_confirm = opts.locale.delete_confirm
  
#   # Build children
#   children_html  = "<ol class='nested_set'>#{ children }</ol>" if children.length > 0

#   """
#     <li id='#{item.id}_#{opts.klass}'>
#       <div class='item'>
#         <i class='handle'></i>
#         <h4>
#           <a href='#{base_path}'>#{item.title}</a>
#         </h4>
        
#         <p>#{item.content}</p>

#         <div class='controls'>
#           <a class='edit'   href='#{edit_path}' title='#{edit_title}'/>
#           <a class='delete' href='#{base_path}' data-confirm='#{delete_confirm}' data-method='delete' title='#{delete_title}'/>
#         </div>
#       </div>
#       #{ children_html }
#     </li>
#   """
# console.timeEnd('tree build')
# Benchmark:
# 3 level deep
# 10 nodes per level
# ~1000 nodes in tree
# 415 ms
# drag&drop sorting works fine

# Benchmark:
# 3 level deep
# 10 nodes per level
# 5000 nodes in tree
# ~2000 ms
# drag&drop sorting - very slow ~ 10sec

# Benchmark:
# 3 level deep
# 25 nodes per level
# 16275 nodes in tree
# Server rendering: 5065.1ms
# Client rendering: 10263ms
# drag&drop sorting - very very slow ~ 30-40sec

# console.time('tree build')

############################################
# Build Sortable Tree
############################################
# Select all trees JSON data and build it
# for data_block in $ '.sortable'
#   console.log '1'
#   # Init
#   data_block  = $ data_block
#   klass       = data_block.find('.klass').html()
#   plural      = data_block.find('.plural').html()
#   rebuild_url = data_block.find('.rebuild_url').html()

#   # Data
#   locale = JSON.parse data_block.find('.locale').html()
#   tree   = JSON.parse data_block.find('.data').html()

#   # console.log 'tree length: ', tree.length

#   # Build tree
#   tree_html = render_tree tree,
#     render_node: render_sortable_node
#     klass:       klass
#     plural:      plural
#     locale:      locale
#     rebuild_url: rebuild_url

#   # Append tree html after JSON data block
#   tree_block = $("<div class='tree_block' />").insertAfter(data_block)
#   tree_block.append """
#     <p class='sortable_new'>
#       <a href='/#{plural}/new'>#{locale.new_path}</a>
#     </p>
#     <ol class='sortable'>
#       #{tree_html}
#     </ol>
#   """