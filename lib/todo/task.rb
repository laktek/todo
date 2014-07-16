require 'SecureRandom'

module Todo
  class Task

    def initialize( description, tags )
      @taskid      = SecureRandom.hex(3)
      @description = description.to_s
      @tags        = tags.to_a
      @created_at  = Time.now.to_s
    end

    def to_h
      {
        "taskid" => @taskid,
        "created_at" => @created_at,
        "description" => @description,
        "tags" => @tags
      }
    end

  end
end
