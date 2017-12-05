require 'yaml'
require 'pry'

module StiDeploy
  class Configuration
    CONFIG_PATH = 'sti_deploy.yml'

    class << self
      attr_reader :config

      def version_path
        read('version_path') || 'config/initializers/version.rb'
      end

      def language
        read('language') || 'en'
      end

      def git_username
        read('git_username') || ''
      end

      private

      def read(config_name)
        unless defined? @config
          @config = YAML::load(File.open(CONFIG_PATH))
        end
        @config[config_name]
      rescue
        @config = nil
      end
    end
  end
end