## Security notes

All data of your tree goes to client as JSON array. It's absolutely open data string.

You should not have important data in this data string.

You should remove passwords, emails, and any important data when you build JSON string.

Simplest way - it's select from data base only fields, which required for tree building.

There is example:

```ruby
@pages = Page.nested_set.select('id, title, content, parent_id').all
```

Select method (or scope) will help to you select only required data.

```ruby
select('id, title, content, parent_id')
```