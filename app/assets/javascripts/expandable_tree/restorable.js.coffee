window.is_restorable_tree = true

class @TSTconst
  @_name        = 'TST'
  @delimiter    = ';'
  @separator    = '|'
  @re           = -> new RegExp(@cookie_name() + '\\' + @separator)
  @hash_prefix  = -> @cookie_name() + @separator
  @cookie_scope = -> $('.sortable_tree').data('cookie_scope') || $('.sortable_tree').data('cookie-scope')
  @cookie_name  = ->
    return @_name unless @cookie_scope()
    @_name + '_' + @cookie_scope()

# ====================================
# Helpers
# ====================================
@_get_hash = -> document.location.hash
@_set_hash = (str) ->
  window.skip_expandable_tree_hashchange = true
  document.location.hash = str

@_uniqueArray = (arr = []) ->
  output = {}
  output[item] = item for item in arr
  val for key, val of output

@_compactArray = (array) -> array.filter (e) -> return e

@_nested_set_hash_arr = (hash) ->
    return [] unless hash
    [prefix, arr] = hash.split(TSTconst.separator)
    _compactArray _uniqueArray arr.split(TSTconst.delimiter)

# ====================================
# Helpers Fn
# ====================================
@nested_tree_get_path = ->
  hash = _get_hash()
  return false unless hash.match(TSTconst.re())
  _nested_set_hash_arr(hash)

@nested_tree_path_remove = (id) ->
  hash  = _get_hash()

  return false unless hash.match(TSTconst.re())
  arr   = _nested_set_hash_arr(hash)
  index = arr.indexOf(id+'')

  if index is -1
    if window.is_cookie_restoreable_tree
      cpath = $.cookie TSTconst.cookie_name()
      return false unless cpath

      _arr = cpath.split(';')
      pos  = _arr.indexOf(id+'')
      return false if pos is -1

      _arr.splice(pos,1)
      str = _arr.join(';')
      $.cookie(TSTconst.cookie_name(), str, { expires: 14 })

    return false

  arr.splice(index, 1)
  str = _uniqueArray(arr).join(TSTconst.delimiter)

  if str.length is 0
    if window.is_cookie_restoreable_tree
      $.removeCookie( TSTconst.cookie_name() )
    _set_hash('')
  else
    if window.is_cookie_restoreable_tree
      $.cookie(TSTconst.cookie_name(), str, { expires: 14 })

    _set_hash(TSTconst.hash_prefix() + str)

  true

@nested_tree_path_add = (id) ->
  str  = id
  hash = _get_hash()

  if hash.match(TSTconst.re())
    arr = _nested_set_hash_arr(hash)
    arr.push(id)
    arr = _uniqueArray arr
    str = arr.join(TSTconst.delimiter)

  if window.is_cookie_restoreable_tree
    $.cookie(TSTconst.cookie_name(), str, { expires: 14 })

  _set_hash(TSTconst.hash_prefix() + str)

# ====================================
# Restore Fn
# ====================================
@load_nested_nodes = (arr, expand_node_url) ->
  return false if arr.length is 0

  id         = arr.shift()
  tree       = $('.sortable_tree')
  node       = $("[data-node-id=#{id}]")
  ctrl_items = $('i.handle, b.expand', tree)

  if node.length is 0
    load_nested_nodes(arr, expand_node_url)
  else
    $.ajax
      type:     'POST'
      dataType: 'html'
      data:     { id: id }
      url:      expand_node_url

      beforeSend: (xhr) ->
        ctrl_items.hide()
        window.skip_expandable_tree_hashchange = true

      success: (data, status, xhr) ->
        ctrl_items.show()
        append_children_to_node(node, data)
        load_nested_nodes(arr, expand_node_url)

      error: (xhr, status, error) ->
        # try
        #   console.log error

@restore_nested_tree = (sortable_tree, expand_node_url) ->
  arr  = nested_tree_get_path()
  return false unless arr
  load_nested_nodes(arr, expand_node_url)