$ ->
  class @CommentsTreeInit
    # SELECTORS
    reply_links:      $('.comments_tree .comment .reply')
    skip_link:        $('.comments_tree .new_comment .skip')
    new_comment_form: $('.comments_tree form.new_comment')
    parent_input:     $(".comments_tree form.new_comment input[name='comment[parent_id]']")

    constructor: ->

      @reply_links.click (event) =>
        # GET DATA
        link         = $ event.target
        comment      = link.parents('.comment')
        title        = comment.find('.title .main')
        hidden_field = comment.find('input:hidden')
        parent_id    = hidden_field.val()

        form         = @new_comment_form
        for_block    = form.find('.for')
        name_field   = for_block.find('i')

        # SET DATA
        name_field.html   title.html()
        @parent_input.val parent_id 

        # SHOW and JUMP
        for_block.show()
        window.location.hash = '#new_comment'

        false

      @skip_link.click (event) =>
        link       = $ event.target
        form       = @new_comment_form
        for_block  = form.find('.for')
        name_field = for_block.find('i')

        name_field.html   ''
        @parent_input.val ''

        for_block.hide()

        false

  new @CommentsTreeInit