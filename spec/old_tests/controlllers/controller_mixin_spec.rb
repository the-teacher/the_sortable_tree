require 'spec_helper'

describe TheSortableTreeController do
  describe "common variable definitions" do
    class BigTest; end

    module ParentModule
      class TestsController < ApplicationController
        include TheSortableTreeController::Rebuild
      end

      class BigTestsController < ApplicationController
        include TheSortableTreeController::Rebuild
      end
    end

    before do
      @test_controller = TestsController.new
      @variable, @collection, @klass = @test_controller.the_define_common_variables 
    end

    it "should define collection" do
      @collection.should == 'tests'
    end

    describe "namespaced controllers" do
      before do
        @test_controller = ParentModule::TestsController.new
        @variable, @collection, @klass = @test_controller.the_define_common_variables 
      end

      it "should handle namespaced collections" do
        @collection.should == 'tests'
      end

    end

    describe "camel cased and namespaced controllers" do
      before do
        @test_controller = ParentModule::BigTestsController.new
        @variable, @collection, @klass = @test_controller.the_define_common_variables 
      end

      it "should handle namespaced collections" do
        @collection.should == 'big_tests'
      end
    end
  end
end