module MyNastyValidators
    NAME_VALIDATION_RULE = /^[a-z]{1}[a-z0-9_\-\.]+[a-z0-9]{1}$/i
    NAME_MIN_LENGTH = 3
    ID_VALIDATION_RULE = /^[a-z0-9]{3}\-?[a-z0-9]{2}$/i
    ID_MIN_LENGTH = 5

    def valid?
      begin
        valid!
      rescue ArgValidationError 
        false
      end
      # after exception handler
      true
    end

    def name_valid?(name)
      validate_name!(id)
    end
  
    def train_id_valid?(id)
      validate_train_id(id)
    end

    private
  
    def validate_name!(name)
      raise ArgValidationError, 'Name must match following pattern: Start with letter, have only [a-zA-Z0-9_-.] characters' if  name !~ NAME_VALIDATION_RULE
      raise ArgValidationError, "Name is too short. Must be minimum #{NAME_MIN_LENGTH}" if name.size < NAME_MIN_LENGTH
    end

    def validate_train_id!(id)
      raise ArgValidationError, "Id must start with 3 letter or digits, followed (or not) by hyphen, followed by 2 letters or digits" if id !~ ID_VALIDATION_RULE 
      raise ArgValidationError, "Id is too short. Must be minimun #{ID_MIN_LENGTH}" if id.size < ID_MIN_LENGTH
    end

end
class ArgValidationError < Exception
end
