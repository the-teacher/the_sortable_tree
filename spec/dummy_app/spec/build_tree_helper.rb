def build_test_tree klass = Page, count = 5
  basic_content = "Hello World!"
  counter = 0

  count.times do |book_i|
    var = klass.new
    var.title        = "Book #{book_i}"
    var.content      = basic_content + Faker::Lorem.sentence(5)
    var.save

    counter = counter.next
    puts '.' + counter.to_s

    count.times do |chapter_i|
      var1 = klass.new
      var1.title        = "Chapter #{chapter_i}"
      var1.content      = basic_content + Faker::Lorem.sentence(5)
      var1.save
      var1.move_to_child_of var

      counter = counter.next
      puts '..' + counter.to_s

      count.times do |page_i|
        var2 = klass.new
        var2.title        = "Page #{page_i}"
        var2.content      = basic_content + Faker::Lorem.sentence(25)
        var2.save

        var2.move_to_child_of var1
        counter = counter.next
        puts '...' + counter.to_s
      end
    end
  end

  puts klass.to_s
  puts klass.count
end