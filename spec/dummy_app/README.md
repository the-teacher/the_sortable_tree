## TheSortableTree Test Application 

#### Ruby 1.9.3 + Rails 4 + Haml 4 + the_sortable_tree (2.3.0)

Create Database config file

```
cp config/database.yml.example config/database.yml
```

Create Database and Test data

```
rake db:drop && rake db:create && rake db:migrate && rake db:seed
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