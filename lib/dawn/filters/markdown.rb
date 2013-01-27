require 'rdiscount'

module Dawn::Filters
   class Markdown
      def self.extension
         ['md']
      end

      def self.process(content)
         RDiscount.new(content).to_html
      end
   end
end
