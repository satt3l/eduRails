class ValidationError < StandardError
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end
  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        begin
          method = self.method("validate_#{validation[:validation_type]}")
          args = validation.values.first(method.arity)
          method.call(*args)
#          send("validate_#{validation[:validation_type].to_sym}", attribute, validation[:arguments])
        rescue ValidationError => e
          raise "Validation #{validation[:validation_type]} failed with message:\n#{e.message}"
        end
      end 
    end

    private

    def validate_presence(attribute)
      raise ValidationError, "Attribute #{attribute} must present" \
      if !instance_variable_defined?("@#{attribute}".to_sym) || instance_variable_get("@#{attribute}".to_sym).empty?
    end

    def validate_format(attribute, regexp)
      puts "att:#{attribute}, r: #{regexp}"
      raise ValidationError, "Attribute #{attribute} must match pattern #{regexp}" unless instance_variable_get("@#{attribute}".to_sym) =~ regexp
    end
     
    def validate_type(attribute, type)
      raise ValidationError, "Attribute #{attribute} must be type of #{type}" unless instance_variable_get("@#{attribute}".to_sym).is_a?(type)
    end
  end
  module ClassMethods
    attr_reader :validations

    def validate(*args)
      attribute_name, validation_type, params = args
      @validations ||= []
      @validations << { attribute_name: attribute_name, arguments: params, validation_type: validation_type}
      puts "type: #{@validations.first[:arguments].class}"
      puts "wer:#{@validations}"
#      @validations << [attribute_name, validation_type, params]
    end

    private

  end
end
