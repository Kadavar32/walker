require "structure_walker/version"

module StructureWalker
  class Builder
    class << self
      def invoke(proc)
        walker = -> (steps, data) do
          return if data.nil?
          if steps.empty?
            result = proc.call(data)
          else
            steps = steps.clone
            step = steps.shift
            key = step.first
            data_type = step.last
            result = case key
                     when :enum
                       if data_type == :hash
                         data.each { |_k,v| walker.call(steps, v) }
                       elsif data_type == :array
                         data.each { |v| walker.call(steps, v) }
                       end
                     when :key
                       walker.call(steps, data[data_type])
                     when :method
                       record = data.send(data_type)
                       walker.call(steps, record)
                     end
          end
          result
        end

        walker
      end
    end
  end
end
