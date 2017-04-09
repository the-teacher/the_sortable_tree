## TheSortableTree Test Application

* Ruby 2.3.3
* Rails 4
* Haml 4
* the_sortable_tree

### Setup the App

1. Copy and configure `database.yml`

  ```
  cp config/database.yml.example config/database.yml
  ```

2. Create DB and Seeds for development

  ```
  rake db:bootstrap_and_seed
  ```

3. Launch the App

  ```
  bin/rails s
  ```

  or

  ```
  bin/rails s -p 3000 -b site.com
  ```

4. Visit the Index page

  ```
  localhost:3000
  ```
