module TreeRender
  class Base
    attr_accessor :context, :options, :h

    def initialize context, options = {}
      @context = context
      @options = options
      @h       = context
    end
  end
end