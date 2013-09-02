require 'spec_helper'
require 'build_tree_helper'

describe "pages/index" do
  include Capybara::DSL

  before(:all) do
    Benchmark.bm do |b|
      b.report{
        Page.all.each{|p| begin; p.destroy; rescue; end; }
      }
    end
    puts "DB Cleaning"

    # sleep 3

    # 5 => 155
    # 6 => 258
    # 7 => 399
    # 8 => 584
    # 9 => 819
    # 10 => 1110
    Benchmark.bm do |b|
      b.report{
        build_test_tree Page, 10
      }
    end
    puts "Tree Building"

  end

  it "render all pages without capybara" do
    assign :pages, Page.all
    render
  end

  it "pages/index" do
    visit '/pages'
    nodes = all('li', visible: true)
    nodes.count.should be 15
  end

  it "pages/manage all pages" do
    visit '/pages/manage'
    nodes = all('li', visible: true)
    nodes.count.should be 1110
  end
end