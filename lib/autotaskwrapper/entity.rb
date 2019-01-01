module Autotaskwrapper
  class Entity
    def initialize
      @data = {}
    end

    def to_s
      @data
    end

    def method_missing(method, *args)
      key = method.to_s
      if @data.key? key
        result = @data[key]
      else
        raise NoMethodError
      end
      result
    end
  end
end

