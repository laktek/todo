require 'rubygems'
require 'yaml'

module Todo
  class Store
      def self.read(file)
        begin
         loaded_list = YAML::load( File.open( file ) )
         loaded_list ? List[loaded_list] : List.new 
        rescue
          nil
        end
      end
      
      def self.write(list, file)
        begin
          File.open( file, 'w' ) do |f|
            f << list.to_yaml
          end
        rescue
          nil
        end
      end
      
  end
end
