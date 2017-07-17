class ValidationError < RuntimeError
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.prepend InstanceMethods
  end
  module InstanceMethods
    def validate!
      self.class.validations.each_pair do |attribute, validations|
        validations.each do |validation|
          begin
            send("validate_#{validation[:validation_type].to_sym}", attribute, validation[:arguments])
          rescue ValidationError => e
            puts "Validation #{validation[:validation_type]} failed with message:\n#{e.message}"
          end
        end
      end 
    end
  end
  module ClassMethods
    attr_reader :validations

    def validate(*args)
      attribute_name, validation_type, params = args
      send("create_validation_method_#{validation_type}", attribute_name, params)  
      @validations ||= {}
      if @validations.key?(attribute_name)
        @validations[attribute_name] << { validation_type: validation_type, arguments: params}
      else
        @validations[attribute_name] = [{ validation_type: validation_type, arguments: params}]
      end
    end

    private

    def create_validation_method_presence(attribute, _ )
      define_method("validate_presence") do |attribute, _|
        true
        raise ValidationError, "Attribute #{attribute} must present" \
          unless instance_variable_defined?("@#{attribute}".to_sym) || instance_variable_get("@#{attribute}".to_sym).empty?
      end
    end
    
    def create_validation_method_format(attribute, regexp)
      define_method("validate_format") do |attribute, regexp|
        true
        raise ValidationError, "Attribute #{attribute} must match pattern #{regexp}" unless instance_variable_get("@#{attribute}".to_sym) =~ regexp
      end
    end
     
    def create_validation_method_type(attribute, type)
      define_method("validate_type") do |attribute, type|
        true
        raise ValidationError, "Attribute #{attribute} must be type of #{type}" unless instance_variable_get("@#{attribute}".to_sym).is_a?(type)
      end
    end
  end
end
