module  InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :prepend, InstanceMethods 
  end

  module ClassMethods
    @@instances = 0

   # protected 
    def instances_inc
      @@instances += 1
    end
    def instances
      @@instances 
    end

  end

  module InstanceMethods

    def initialize(*args)
      register_instance
      super
    end

    protected

    def register_instance
      self.class.instances_inc 
    end

  end

end
