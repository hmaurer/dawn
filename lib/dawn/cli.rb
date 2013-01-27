require 'pathname'
require 'fileutils'
require 'listen'
require 'rack'
require 'thor'

module Dawn
  class CLI < Thor
    include Thor::Actions

    def self.source_root
      File.expand_path('../../..', __FILE__)
    end

    desc 'build', 'Build the current project'

    def build
       require 'dawn/project'
       require 'dawn/compiler'
       
       project = Dawn::Project.new(Dir.pwd) 
       Compiler.register_filter :Markdown
       puts Compiler.compile_project(project).inspect
    end

    desc 'version', 'Show the current version of Dawn'

    def version
      require 'dawn/version'
      puts "Dawn Version #{Dawn::VERSION}"
    end
  end
end
