(in /home/lakshan/projects/ruby-samples/todo)
Gem::Specification.new do |s|
  s.name = %q{todo}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lakshan Perera"]
  s.date = %q{2008-08-28}
  s.default_executable = %q{todo}
  s.description = %q{simple command line todo list manager}
  s.email = ["lakshan@web2media.net"]
  s.executables = ["todo"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "website/index.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/todo", "config/hoe.rb", "config/requirements.rb", "lib/todo.rb", "lib/todo/version.rb", "lib/todo/cli.rb", "lib/todo/list.rb", "lib/todo/store.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/website.rake", "spec/todo_list_specs.rb", "spec/todo_store_specs.rb", "website/index.html", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://todo.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{todo}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{simple command line todo list manager}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<main>, [">= 2.8.2"])
      s.add_runtime_dependency(%q<highline>, [">= 1.4.0"])
    else
      s.add_dependency(%q<main>, [">= 2.8.2"])
      s.add_dependency(%q<highline>, [">= 1.4.0"])
    end
  else
    s.add_dependency(%q<main>, [">= 2.8.2"])
    s.add_dependency(%q<highline>, [">= 1.4.0"])
  end
end
