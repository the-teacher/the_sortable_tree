@comment_reply_blocks_to_default = ->
  blocks = '.tree_block .comments .reply_block'
  $('a.skip',  blocks).hide()
  $('a.reply', blocks).show()

@new_comment_submit_initialize = ->
  $('#new_comment_block input[type=submit]').click (e) ->
    button = $ e.target
    form   = button.parent()
    # potential ajax submit
    form.submit()
    false  

@reply_links_initialize = ->
  $('.tree_block .comments .reply_block a.reply').click (e) ->
    reply   = $ e.target
    holder  = reply.parents '.reply_block'
    comment = reply.parents '.comment'
    skip    = reply.siblings '.skip'
    form    = $ '#new_comment_block'
    # set parent id
    parent_id       = comment.attr 'data-comment-id'
    parent_id_field = form.find "input[name='comment[parent_id]']"
    parent_id_field.val(parent_id)
    # reset to default state
    comment_reply_blocks_to_default()
    # actions
    reply.hide()
    skip.show()
    holder.after form

    false

@skip_links_initialize = ->
  $('.tree_block .comments .reply_block a.skip').click (e) ->
    skip  = $ e.target
    reply = skip.siblings '.reply'
    form  = $ '#new_comment_block'
    # reset to default state
    comment_reply_blocks_to_default()
    parent_id_field = form.find "input[name='comment[parent_id]']"
    parent_id_field.val('')
    # actions
    skip.hide()
    reply.show()
    $('#new_comment_holder').append form

    false

$ ->
  ############################################
  # Build Sortable Tree
  ############################################
  # Select all trees JSON data and build it
  for data_block in $ '.comments_tree'
    # Init
    data_block  = $ data_block
    klass       = data_block.find('.klass').html()
    plural      = data_block.find('.plural').html()
    rebuild_url = data_block.find('.rebuild_url').html()

    # Data
    t    = JSON.parse data_block.find('.locale').html()
    tree = JSON.parse data_block.find('.data').html()

    # Build tree
    tree_html = render_tree tree,
      render_node: render_comment_node
      klass:       klass
      plural:      plural
      locale:      t
      rebuild_url: rebuild_url

    # Append tree html after JSON data block
    tree_block = $("<div class='tree_block' />").insertAfter(data_block)
    tree_block.append """
      <ol class='comments'>
        #{tree_html}
      </ol>
    """

$ ->
  skip_links_initialize()
  reply_links_initialize()
  new_comment_submit_initialize()
