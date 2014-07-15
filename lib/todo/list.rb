module Todo

  class List < Hash

    def tagged(tag)
      self.reject do |name, tags|
        not tags.include?(tag)
      end
    end

    def add(task, *tags)
      self.store(task, tags.flatten)
      self
    end

    #Returns the list after removing specific item
    def remove(task)
      #find key by index
      task = self.keys[task - 1] if task.instance_of? Fixnum
      self if self.delete(task)
    end

  end
end
