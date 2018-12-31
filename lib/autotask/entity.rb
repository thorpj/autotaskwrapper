module AutotaskWrapper
  class Entity
    def initialize
      @data = {}
    end

    def method_missing(method, *args)
      result = nil
      unless args.nil?
        key = args.first
        if @data.key? key
          result = @data[key]
        end
      end
      result
    end
  end
end

