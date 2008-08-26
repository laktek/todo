require 'rubygems'
require 'main'
require 'highline/import'
require 'ftools'

def read_file(environment)
  file = environment.nil? ? Todo::Store.read('.todo/list.yml') : Todo::Store.read(environment)
end

def write_file(list, environment)
  file = environment.nil? ? Todo::Store.write(list, '.todo/list.yml') : Todo::Store.write(list, environment)
end

Main {
  def run
    puts "todo [command] --help for usage instructions."
    puts "The available commands are: \n   add, remove, list, modify."
  end
  
  mode 'create' do
    description 'Creates a new todo list for this directory'
    
    def run
      unless File.exist?(".todo/list.yml")
        File.makedirs(".todo")
        newfile = File.new(".todo/list.yml", "w+")
        say "Created a new todo list inside this directory" if newfile
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
        tags = ask("Enter tags for this item (seperate from commas)', (comma sep list)", lambda {|str| 
               str.split(/,\s*/) })
       end
       
       #read the YAML file
       if list=read_file(params['FILE'].value)
        #add the task
        list.add(params['item'].value, tags)
        #write the changes
        say "Successfully added your task." if write_file(list, params['FILE'].value)
       else
        say "Todo list file is invalid or do not exist."
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
       description 'name of the todo item to remove'
    }
    
    option('index', 'i'){
      cast :int
      argument :required
    }
       
    def run
      if list=read_file(params['FILE'].value)
        if list.remove(params['item'].value || params['index'].value)
          say "Removed item from the list." if write_file(list, params['FILE'].value)
        else 
          say "Could not find item to remove."
        end
      else
        say "Todo list file is invalid or do not exist."
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
      if list=read_file(params['FILE'].value)
      
        if params['tag'].given?
          title = "Listing todos tagged '#{params['tag'].value}'"
          tasks = list.tagged(params['tag'].value) 
        else
          title = "Listing all todos"
          tasks = list
        end
             
        say title
        tasks.each do |task, tags|
          tag_string = ("(#{tags.join(", ")})") unless tags.include?(nil)
          say " - #{task} #{tag_string} \n"
        end
      else
        say "Todo list file is invalid or do not exist."
      end
    end  
  end
}
