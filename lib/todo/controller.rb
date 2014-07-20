require 'fileutils'
require 'highline/import'
require 'SecureRandom'
require 'yaml'

module Todo

  def self.add_task(filename,notags,description,taskid=SecureRandom.hex(4),created_at=Time.now.to_s)
    tags   = []
    _tasks = load_tasks(filename)
    tags   = ask("(optional) Enter comma-separated tags: ", lambda {|s| s.split(/,\s*/) }) unless notags

    _tasks << {
      "taskid" => taskid,
      "created_at" => created_at,
      "description" => description,
      "tags" => tags
    }

    "<%= color('Task added', :green) %>" if(save_tasks(filename,_tasks))
  end

  def self.del_task(filename,index)
    _tasks=load_tasks(filename)
    if(_tasks.delete_at(index-1) && save_tasks(filename,_tasks))
      "<%= color('Task deleted', :yellow) %>"
    else
      "<%= color('No task deleted', :red) %>"
    end
  end

  def self.show_tasks(filename,tag)
    _tasks=load_tasks(filename)

    _rtn      = "Listing tasks (#{tag ? tag.to_s : 'all'})\n"
    _tasks.each_with_index do |task, i|
      next if(tag && !(task["tags"].include?(tag)))
      _rtn   += "(#{i+1})\n"
      _rtn   += "\t taskid      : #{task['taskid']}\n"
      _rtn   += "\t created_at  : #{task['created_at']}\n"
      _rtn   += "\t description : <%= color('"+task['description']+"', :yellow) %>\n"
      unless(task['tags'].empty?)
        _rtn += "\t tags        : #{task['tags']}\n\n"
      end
    end
    _rtn
  end

  #

  def self.save_tasks(filename,tasks,file=File)
    begin
      File.open(filename,"w+") { |f| f << tasks.to_yaml }
    rescue
      nil
    end
  end

  def self.load_tasks(filename)
    begin
      _tasks = YAML::load(File.open(filename))
    rescue
      nil
    end
    _tasks ? _tasks : []
  end

  private_class_method :save_tasks, :load_tasks

end
