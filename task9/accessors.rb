module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var = "@#{name}".to_sym
      history_instance_var = "@#{name}_history".to_sym
      history_name = "#{name}_history"

      define_method(history_name) { instance_variable_get(history_instance_var) }
      define_method(name) { instance_variable_get(var) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_defined?(history_instance_var) || instance_variable_set(history_instance_var, [])
        send(history_name).push(value)
#        eval("@#{history_name} << #{value}")

        instance_variable_set(var, value) 
      end
    end
  end
  
  def strong_accessor(type, name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method "#{name}=" do |value|
      if value.is_a?(type) 
        instance_variable_set(var_name, value)
      else
        raise ArgumentError, "Error. Specified type #{value.class} is not #{type}."
      end
    end
  end
end

class Test
  extend Accessors
  attr_accessor_with_history :some
  strong_accessor Fixnum, :mega
end
