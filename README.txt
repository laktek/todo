= Simple command-line todo list manager

Really want to get things done? Don't want to juggle with web based todo lists? 
Get your things done with command-line. No hassle, no distraction - Try out todo ruby gem. 


== FEATURES:

* Uses human readable YAML to store the todo lists (You could edit the todo list manually)
* Supportss project specific todo lists. (Just run 'todo create' in your project directory)
* Supports tagging.

== Install

First make sure you install the dependency gems.
  sudo gem install main
  sudo gem install highline

  then;
  sudo gem install todo
  
  You can also install from github:
  gem sources -a http://gems.github.com
  sudo gem install laktek-todo
  
== Example:

  Here is a small sample on how to use todo gem
  
  #visit your project folder
  cd projects/newapp
  
  #create a new todo list for the project
  todo create
  
  #add a new task
  todo add "write the specs"
  - add tags : important, due:24/08/2008
  
  #listing all tasks
  todo list --all
  
  #listing tasks tagged 'important'
  todo list --tag important
  
  #removing a task by name
  todo remove "write the specs"
  
  #removing a task by index
  todo remove -i 1
  
== Issues/Improvements

Todo is still its infant days and have very minimum functionality. If you come across any issues or like to suggest any improvements, please feel free to contact me : lakshan [at] web2media [dot] net



