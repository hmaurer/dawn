module Dawn
   class CompiledAsset
      def initialize filename, content, destination
         @filename = filename
         @content = content
         @destination = destination
      end
   end
end
