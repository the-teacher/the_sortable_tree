$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "the_sortable_tree/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the_sortable_tree"
  s.version     = TheSortableTree::VERSION
  s.authors     = ["Ilya N. Zykin, Mikhail Dieterle, Matthew Clark"]
  s.email       = ["zykin-ilya@ya.ru"]
  s.homepage    = "https://github.com/the-teacher/the_sortable_tree"
  s.summary     = %q{Sortable awesom_nested_set, Drag&Drop GUI for awesom_nested_set, View Helper for nested set, Nested Comments}
  s.description = %q{Sortable awesom_nested_set, Drag&Drop GUI for awesom_nested_set, View Helper for nested set, Nested Comments}
  s.rubyforge_project = "the_sortable_tree"
  s.extra_rdoc_files = ["README.md"]

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 3.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
end
