require 'json'
require 'dawn/asset'

module Dawn
   class Project
      attr_accessor :assets

      def initialize root_path
         puts "Source: #{Dir.pwd}"
         @root_path = root_path
         load_config
         discover_assets
      end

      def load_config
         config_path = "#{@root_path}/build.json" 
         if File.exists?(config_path)
            @config = JSON.parse File.read(config_path)
         else
            raise "Could not find build.json."
         end
      end

      # To improve
      def discover_assets
         excluded_assets = []
         @config["exclude"].each do |path|
            excluded_assets.push *Dir.glob(path).select { |f| File.file?(f) }
         end

         assets = []
         @config["deploy"].each do |p, d|
            base_path = File.dirname(p)
            path = p.gsub(/\(([a-zA-Z_.\s\/]+)\)/) do
               base_path = $1
            end
            base_path = File.expand_path(base_path)

            asset_paths = Dir.glob(path).select { |f| File.file?(f) && !excluded_assets.include?(f) }
            asset_paths.each do |asset|
               destination = File.dirname(File.expand_path(asset)).gsub(/^#{base_path}/, '')
               assets.push Asset.load(asset, File.join(d, destination))
            end
         end

         @assets = assets
         puts assets.inspect
      end
   end
end
