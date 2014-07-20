require 'rubygems'
require 'main'
require 'fileutils'
require 'highline/import'

#
TODO_FILE   = '.todo/list.yml'
ADD_DESC    = "Adds a new task"
REMOVE_DESC = "Removes a task from this todo list"
LIST_DESC   = "Lists the tasks"
#

Main {

  def run
    puts "todo [command] --help for usage instructions."
    puts
    puts "The available commands are:"
    puts "  - add    => #{ADD_DESC}"
    puts "  - remove => #{REMOVE_DESC}"
    puts "  - list   => #{LIST_DESC}"
    puts
  end

  mode 'add' do
    description ADD_DESC
    argument('task'){ description 'Task to add' }

    option('notags', 'n'){
      cast :bool
      default false
    }

    define_method(:run) { say(Todo::add_task(TODO_FILE,
                                             params['notags'].value,
                                             params['task'].value)) }
  end

  mode 'remove' do
    description REMOVE_DESC

    argument('index'){
      required
      cast :int
      validate { |index| index>0 }
      description 'Task number to remove'
    }

    define_method(:run) { say(Todo::del_task(TODO_FILE,params['index'].value)) }
  end

  mode 'list' do
    description LIST_DESC

    option('tag', 't') { argument_required }

    option('all=[all]', 'a'){
      cast :bool
      default false
    }

    define_method(:run) { say(Todo::show_tasks(TODO_FILE,params['tag'].value)) }

  end
}
