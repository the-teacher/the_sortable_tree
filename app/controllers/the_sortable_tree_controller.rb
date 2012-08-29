module TheSortableTreeController
  # include TheSortableTreeController::ReversedRebuild
  # include TheSortableTreeController::Rebuild
  
  module DefineVariablesMethod
    public
    def the_define_common_variables
      collection = self.class.to_s.split(':').last.sub(/Controller/,'').underscore.downcase                 # recipes
      variable   = collection.singularize                                                                   # recipe
      klass      = self.respond_to?(:sortable_model) ? self.sortable_model : variable.classify.constantize  # Recipe
      ["@#{variable}", collection, klass]
    end

    def the_define_common_variables_for_engine
      collection = self.class.to_s.split(':').last.sub(/Controller/,'').underscore.downcase                 # recipes
      variable   = collection.singularize                                                                   # recipe
      modules_of_klass = self.class.to_s.split('::')[0...-1]
      klass      = self.respond_to?(:sortable_model) ? self.sortable_model : ( (modules_of_klass.join("/") + "/" + variable ).classify.constantize )  # Recipe or SomeModule::Recipe
      ["@#{variable}", collection, klass]
    end
  end

  module Rebuild
    include DefineVariablesMethod
    public
    def rebuild
      id        = params[:id].to_i
      parent_id = params[:parent_id].to_i
      prev_id   = params[:prev_id].to_i
      next_id   = params[:next_id].to_i

      render :text => "Do nothing" and return if parent_id.zero? && prev_id.zero? && next_id.zero?

      variable, collection, klass = self.the_define_common_variables
      variable = self.instance_variable_set(variable, klass.find(id))

      if prev_id.zero? && next_id.zero?
        variable.move_to_child_of klass.find(parent_id)
      elsif !prev_id.zero?
        variable.move_to_right_of klass.find(prev_id)
      elsif !next_id.zero?
        variable.move_to_left_of klass.find(next_id)
      end

      render(:nothing => true)
    end
  end
  
  module ReversedRebuild
    include DefineVariablesMethod
    public
    def rebuild
      id        = params[:id].to_i
      parent_id = params[:parent_id].to_i
      prev_id   = params[:prev_id].to_i
      next_id   = params[:next_id].to_i

      render :text => "Do nothing" and return if parent_id.zero? && prev_id.zero? && next_id.zero?

      variable, collection, klass = self.the_define_common_variables
      variable = self.instance_variable_set(variable, klass.find(id))

      if prev_id.zero? && next_id.zero?
        variable.move_to_child_of klass.find(parent_id)
      elsif !prev_id.zero?
        variable.move_to_left_of klass.find(prev_id)
      elsif !next_id.zero?
        variable.move_to_right_of klass.find(next_id)
      end

      render(:nothing => true)
    end
  end
  
  # For including on Engine models, 'cause engine models looks like EngineFoo::Model
  module EngineRebuild
    include DefineVariablesMethod
    public
    def rebuild
      id        = params[:id].to_i
      parent_id = params[:parent_id].to_i
      prev_id   = params[:prev_id].to_i
      next_id   = params[:next_id].to_i

      render :text => "Do nothing" and return if parent_id.zero? && prev_id.zero? && next_id.zero?

      variable, collection, klass = self.the_define_common_variables_for_engine
      variable = self.instance_variable_set(variable, klass.find(id))

      if prev_id.zero? && next_id.zero?
        variable.move_to_child_of klass.find(parent_id)
      elsif !prev_id.zero?
        variable.move_to_left_of klass.find(prev_id)
      elsif !next_id.zero?
        variable.move_to_right_of klass.find(next_id)
      end

      render(:nothing => true)
    end
  end

end
