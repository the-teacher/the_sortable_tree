@_arrays_diff = (a, b) -> b.filter (i) -> return !(a.indexOf(i) > -1)

@expandable_tree_hashchange = (hash_event) ->
  if window.skip_expandable_tree_hashchange
    window.skip_expandable_tree_hashchange = false
    return true

  hash_and_cookie_accordance()
  
  oEvent  = hash_event.originalEvent
  new_url = oEvent.newURL
  old_url = oEvent.oldURL

  new_hash = new_url.split('#')[1]
  old_hash = old_url.split('#')[1]

  return false unless ('#'+new_hash).match(TSTconst.re()) or ('#'+old_hash).match(TSTconst.re())

  new_arr = _nested_set_hash_arr(new_hash)
  old_arr = _nested_set_hash_arr(old_hash)
  
  diff_ids = if new_arr.length >= old_arr.length
    _arrays_diff(old_arr, new_arr)
  else
    _arrays_diff(new_arr, old_arr)

  for id in diff_ids
    btn = $("[data-node-id=#{id}] > .item .expand")
    btn.click()
    setTimeout -> window.skip_expandable_tree_hashchange = false

$(window).bind 'hashchange', (hash_event) ->
  expandable_tree_hashchange(hash_event)