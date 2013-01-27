require 'dawn/compiled_asset'

module Dawn
   class Compiler
      def self.compile_project(project)
         compiled_assets = []
         project.assets.each do |asset|
            compiled_assets.push self.compile_asset(asset)
         end
         compiled_assets
      end

      def self.compile_asset(asset)
         content = asset.content
         filter_stack = asset.filter_stack.clone
         while filter_stack.length > 0
            f = filter_stack.first
            break unless @filters.include? f
            content = @filters[f].process(content)
            filter_stack.shift
         end

         name = [asset.name, filter_stack.reverse.join('.')].join '.'
         CompiledAsset.new(name, content, asset.destination)
      end

      def self.register_filter(name)
         @filters ||= {}
         require "dawn/filters/#{name.to_s.downcase}"
         klass = Dawn::Filters.const_get(name)
         klass.extension.each do |e|
            @filters[e] = klass
         end
      end
   end
end
