module StructureWalker
  module Steps
    HASH_STEP = [:hash, -> (data, steps, walker, _keys) { data.each { |_k,v| walker.call(steps, v) } }]

    ARRAY_STEP = [:array, -> (data, steps, walker, _keys) { data.each { |v| walker.call(steps, v) } }]

    LAMBDA_FOR_KEY = -> (data, steps, walker, keys) do
      keys = [keys].flatten; keys.each { |type| walker.call(steps, data[type]) }
    end

    KEY_STEP = [:key, LAMBDA_FOR_KEY]

    KEYS_STEP = [:keys, LAMBDA_FOR_KEY]
  end
end