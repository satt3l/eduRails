module  InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.prepend InstanceMethods 
  end

  module ClassMethods
    attr_reader :instances
    
    def instances_inc
      @instances = 0 if @instances.nil?
      @instances += 1
    end

  end

  module InstanceMethods
    
    def initialize(*args)
      register_instance
      super
    end

    def register_instance
      self.class.instances_inc
    end

  end

end
