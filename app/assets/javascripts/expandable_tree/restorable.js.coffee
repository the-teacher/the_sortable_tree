window.is_restorable_tree = true

# ====================================
# Helpers
# ====================================
@_get_hash = -> document.location.hash
@_set_hash = (str) -> document.location.hash = str

@_uniqueArray = (arr = []) ->
  output = {}
  output[item] = item for item in arr
  val for key, val of output

@_compactArray = (array) -> array.filter (e) -> return e

@_nested_set_hash_arr = (hash) ->
    [prefix, arr] = hash.split('|')
    _compactArray _uniqueArray arr.split(';')

# ====================================
# Helpers Fn
# ====================================
@nested_tree_get_path = ->
  hash = _get_hash()
  return false unless hash.match(/TST\|/)
  _nested_set_hash_arr(hash)

@nested_tree_path_remove = (id) ->
  hash  = _get_hash()
  return false unless hash.match(/TST\|/)
  arr   = _nested_set_hash_arr(hash)
  index = arr.indexOf(id)
  return false if index is -1

  arr.splice(index, 1)
  str = _uniqueArray(arr).join(';')
  str = if str.length is 0 then '' else ("TST|" + str)
  _set_hash(str)
  
@nested_tree_path_add = (id) ->
  str  = id
  hash = _get_hash()

  if hash.match(/TST\|/)
    arr = _nested_set_hash_arr(hash)
    arr.push(id)
    arr = _uniqueArray arr
    str = arr.join(';')

  _set_hash("TST|" + str)

# ====================================
# Restore Fn
# ====================================
@load_nested_nodes = (arr, expand_node_url) ->
  return false if arr.length is 0

  id         = arr.shift()
  tree       = $('.sortable_tree')
  klass      = tree.data('klass')
  node       = $ "##{id}_#{klass}"
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

      success: (data, status, xhr) ->
        ctrl_items.show()
        append_children_to_node(node, data)
        load_nested_nodes(arr, expand_node_url)

      error: (xhr, status, error) ->
        console.log error

@restore_nested_tree = (sortable_tree, expand_node_url) ->
  arr  = nested_tree_get_path()
  return false unless arr
  load_nested_nodes(arr, expand_node_url)