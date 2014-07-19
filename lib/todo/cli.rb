require 'rubygems'
require 'main'
require 'highline/import'
require 'fileutils'
require 'SecureRandom'

def read_tasks(environment)
  file = environment.nil? ? Todo::Store.read('.todo/list.yml') : Todo::Store.read(environment)
  if file
    yield(file)
  else
    say "Todo list file is invalid or do not exist."
  end
end

def write_tasks(tasks, environment)
  file = environment.nil? ? Todo::Store.write(tasks, '.todo/list.yml') : Todo::Store.write(tasks, environment)
end

Main {
  def run
    puts "todo [command] --help for usage instructions."
    puts "The available commands are: \n   create, add, remove, list."
  end

  mode 'create' do
    description 'Creates a new todo list for this directory'

    def run
      unless File.exist?(".todo/list.yml")
        FileUtils.makedirs(".todo")
        newfile = File.new(".todo/list.yml", "w+")
        say "Created a new todo list" if newfile
        newfile.close
      else
         say "Todo list already exists inside this directory"
      end
    end
  end

  mode 'add' do
    description 'Adds a new todo item'
     argument('item'){
        description 'todo item to add'
     }

     environment('FILE'){
        synopsis 'export FILE=path'
     }

     option('notags', 'n'){
      cast :bool
      default false
     }

    def run
       unless params['notags'].value
        tags = ask("(optional) Enter comma-separated tags: ", lambda {|s| s.split(/,\s*/) })
       end

      read_tasks(params['FILE'].value) do |tasks|
        # tasks << Todo::Task.new(params['item'].value, tags).to_h
        tasks << {
          "taskid" => SecureRandom.hex(4),
          "created_at" => Time.now.to_s,
          "description" => params['item'].value,
          "tags" => tags
        }
        say "Successfully added your task" if write_tasks(tasks, params['FILE'].value)
       end
    end
  end

  mode 'remove' do
    description 'Removes an item from todo list'

    environment('FILE'){
        synopsis 'export FILE=path'
     }

    argument('item'){
       argument_optional
       description 'Name of the todo item to remove'
    }

    option('index', 'i'){
      cast :int
      argument :required
      description 'Index of the todo item to remove. Use instead of item name'
    }

    def run
      read_tasks(params['FILE'].value) do |tasks|
        if( index = params['index'].value )
          tasks.delete_at((index-1))
        elsif( params['item'].value )
          tasks.reject! { |t| t["description"]==params['item'].value }
        end
        say "Task deleted" if( write_tasks(tasks, params['FILE'].value) )
      end
    end
  end

  mode 'list' do
    description 'Lists todo items'

    environment('FILE'){
        synopsis 'export barfoo=value'
     }

    option('tag', 't'){
      argument_required
    }

    option('all=[all]', 'a'){  # note shortcut syntax for optional args
        #argument_optional      # we could also use this method
        cast :bool
        default false
    }

    def run

      read_tasks(params['FILE'].value) do |list|

        if params['tag'].given?
          title = "Listing todos tagged '#{params['tag'].value}'"
          tasks = list.select { |t| t["tags"].include?( params['tag'].value ) }
        else
          title = "Listing all todos"
          tasks = list
        end

        say title
        i = 0
        tasks.each do |task|
          rtn  = ""
          rtn += "(#{i+=1})\n"
          rtn += "\t taskid      : #{task['taskid']}\n"
          rtn += "\t created_at  : #{task['created_at']}\n"
          rtn += "\t description : #{task['description']}\n"
          rtn += "\t tags        : #{task['tags']}\n\n"
          say rtn
        end

      end
    end
  end
}
