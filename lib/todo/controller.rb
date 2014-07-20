require 'fileutils'
require 'highline/import'
require 'SecureRandom'
require 'yaml'

module Todo

  def self.create_todo_list(file)
    unless File.exist?(file)
      FileUtils.makedirs(".todo")
      _newfile = File.new(file,"w+")
      if _newfile
        say "<%= color('New todo list created', :green) %>"
        _newfile.close
      end
    else
      say "<%= color('Todo list already exists in this directory', :yellow) %>"
    end
  end

  def self.add_task(file,notags,description)
    tags  = []

    _tasks=load_tasks(file)
    tags = ask("(optional) Enter comma-separated tags: ", lambda {|s| s.split(/,\s*/) }) unless notags

    _tasks << {
      "taskid" => SecureRandom.hex(4),
      "created_at" => Time.now.to_s,
      "description" => description,
      "tags" => tags
    }
    say "<%= color('Successfully added your task', :green) %>" if(save_tasks(file, _tasks))
  end

  def self.del_task(file,index)
    _tasks=(load_tasks(file).delete_at(index-1))
    say "<%= color('Task deleted', :yellow) %>" if(save_tasks(file,_tasks))
  end

  def self.show_tasks(file,tag)
    _tasks=load_tasks(file)
    tag.nil? ? (tag="all") : (_tasks.select! {|t| t["tags"].include?(tag)})

    say "Listing tasks (#{tag.to_s})"

    _tasks.each_with_index do |task, i|
      _rtn    = ""
      _rtn   += "(#{i+1})\n"
      _rtn   += "\t taskid      : #{task['taskid']}\n"
      _rtn   += "\t created_at  : #{task['created_at']}\n"
      _rtn   += "\t description : <%= color('"+task['description']+"', :green) %>\n"
      unless(task['tags'].empty?)
        _rtn += "\t tags        : #{task['tags']}\n\n"
      end
      say _rtn
    end
  end

  #

  def self.save_tasks(file, tasks)
    begin
      File.open(file,'w') { |f| f << tasks.to_yaml }
    rescue
      nil
    end
  end

  def self.load_tasks(file)
    begin
      _tasks = YAML::load(File.open(file))
    rescue
      nil
    end
    _tasks ? _tasks : []
  end

  private_class_method :save_tasks, :load_tasks

end
