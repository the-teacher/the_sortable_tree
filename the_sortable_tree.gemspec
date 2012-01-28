$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "the_sortable_tree/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the_sortable_tree"
  s.version     = TheSortableTree::VERSION
  s.authors     = ["Ilya N. Zykin, Matthew Clark"]
  s.email       = ["zykin-ilya@ya.ru"]
  s.homepage    = "https://github.com/the-teacher/the_sortable_tree"
  s.summary     = %q{Drag&Drop GUI helper for awesome_nested_set gem. Sortable tree view helper}
  s.description = %q{Drag&Drop GUI helper for awesome_nested_set gem. Sortable tree view helper}
  s.rubyforge_project = "the_sortable_tree"
  s.extra_rdoc_files = ["README.md"]

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  # s.add_dependency "haml", "~> 3.0"
  # s.add_dependency "jquery-rails"

  s.add_dependency "rails", "~> 3.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
end
