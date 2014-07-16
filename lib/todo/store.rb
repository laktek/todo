require 'rubygems'
require 'yaml'

module Todo
  class Store

    # tasks should be an array of hashes, we can convert the array to
    # a yaml directly by invoking .to_yaml on the array: [].to_yaml
    def self.write(tasks, file)
      begin
        File.open( file, 'w' ) { |f| f << tasks.to_yaml }
      rescue
        nil
      end
    end

    def self.read(file)
      begin
        tasks = YAML::load( File.open( file ) )
      rescue
        nil
      end
      tasks ? tasks : []
    end

  end
end
