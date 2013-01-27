module Dawn
   class Asset
      def self.load path, destination
         name = File.basename(path)
         content = File.read(path)
         Asset.new(name, content, destination)
      end
      
      attr_accessor :filename, :content, :destination

      def initialize filename, content, destination
         @filename = filename
         @content = content
         @destination = destination

         puts "NAME: #{name}"
         puts "Filter stack: #{filter_stack.inspect}"
      end

      def name
         @components ||= @filename.split('.')
         @components[0]
      end

      def filter_stack
         @components[1, @components.length - 1].reverse
      end
   end
end
