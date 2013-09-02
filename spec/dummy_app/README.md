## TheSortableTree Test Application 

#### Ruby 2.0.0p247 + Rails 4 + Haml 4 + the_sortable_tree (2.3.0)

Create Database config file

```
cp config/database.yml.example config/database.yml
```

Create Database and Test data

```
rake db:bootstrap_and_seed
```

Start Rails 4

```
rails s
```

or

```
rails s -p 3000 -b site.com
```

Open browser

```
localhost:3000
```

How to test TheSortable tree

```ruby
git clone git@github.com:the-teacher/the_sortable_tree.git
cd the_sortable_tree/spec/dummy_app/

# cp config/database.yml.example config/database.yml

rake db:bootstrap RAILS_ENV=test
rspec
```