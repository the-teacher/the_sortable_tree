# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

@text_1 = "Unsafe content <script>alert(1)</script>!!! ' ' \" "
@text_2 = "<script>alert('!!! Some Secret word !!!')</script> It's should be removed from JSON"

@counter_1 = 0

def build_test_tree klass = Page, count = 5
  count.times do |book_i|
    var = klass.new
    var.title        = "Book #{book_i}"
    var.content      = @text_1 + Faker::Lorem.sentence(5)
    var.secret_field = @text_2
    var.save

    @counter_1 = @counter_1.next
    puts '.' + @counter_1.to_s

    count.times do |chapter_i|
      var1 = klass.new
      var1.title        = "Chapter #{chapter_i}"
      var1.content      = @text_1 + Faker::Lorem.sentence(5)
      var1.secret_field = @text_2
      var1.parent = var
      var1.save

      var1.move_to_child_of var

      @counter_1 = @counter_1.next
      puts '..' + @counter_1.to_s

      count.times do |page_i|
        var2 = klass.new
        var2.title        = "Page #{page_i}"
        var2.content      = @text_1 + Faker::Lorem.sentence(25)
        var2.secret_field = @text_2
        var1.parent = var1
        var2.save

        var2.move_to_child_of var1

        @counter_1 = @counter_1.next
        puts '...' + @counter_1.to_s
      end
    end
  end

  puts klass.to_s
  puts klass.count
end

# 20 - 8420
build_test_tree Page, 7

build_test_tree ArticleCategory, 4

build_test_tree Inventory::Category, 4
build_test_tree Admin::Page, 4

# def build_test_comments count = 3
#   count.times do
#     var             = Comment.new
#     var.name        = Faker::Name.name
#     var.email       = Faker::Internet.free_email
#     var.raw_content = Faker::Lorem.sentence(2)
#     var.save

#     puts '.'
#     count.times do
#       var1             = Comment.new
#       var1.name        = Faker::Name.name
#       var1.email       = Faker::Internet.free_email
#       var1.raw_content = Faker::Lorem.sentence(2)
#       var1.save

#       var1.move_to_child_of var
#       puts '..'

#       count.times do
#         var2             = Comment.new
#         var2.name        = Faker::Name.name
#         var2.email       = Faker::Internet.free_email
#         var2.raw_content = Faker::Lorem.sentence(2)
#         var2.save

#         var2.move_to_child_of var1
#         puts '...'
#       end
#     end
#   end
#   puts 'Comments'
#   puts Comment.count
# end

# build_test_comments 4
