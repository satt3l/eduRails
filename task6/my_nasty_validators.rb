module MyNastyValidators
  class ValidationError < Exception
  end

  class FormatError < ValidationError
  end
  
  class LengthError < ValidationError
  end
  
  private
  def validate_format!(text, regexp)
    raise FormatError, "Name must follow format #{regexp.to_s}" if text !~ regexp
  end

  def validate_length!(text, length)
    raise LengthError, "Text must NOT be less thatn #{length}" if text.size < length
  end

end



