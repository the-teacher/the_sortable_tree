## How gem works?

#### Server side (ruby/rails)

- Tree select from database (Controller)
- Tree convertet to JSON (Controller)
- Insert JSON into HTML tag(View)

#### Client side (JavaScript)

- select JSON data from HTML tag
- parse JSON data and get Object (Hash-like structure)
- build HTML tree with recursive function
- append HTML result to tree holder

### Why JSON put into HTML tag, but not in SCRIPT tag?

Because when we put JSON in SCRIPT tag it can call JavaScript code in content fields of tree.

When we put JSON in HTML tag potentially dangerous code cannot be evalut.

Next code is example of unsecure way to get tree

```javascript
<script>
//<![CDATA[
  tree = { field: "</script><script>alert(1)</script>" }
//]]>
</script>
```

Next code is example of secure way to get Tree data at client side.

```javascript
<script> //<![CDATA[
  tree = $('#json_data').html()
  tree = JSON.parse(tree)
</script>
```

If you know better way - just say me, and I will use it