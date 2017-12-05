# frozen_string_literal: true

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

      def origin_branch(deploy_type)
        read('branches')[deploy_type.full_name]['origin'] || 'master'
      rescue StandardError
        'master'
      end

      def target_branch(deploy_type)
        read('branches')[deploy_type.full_name]['target'] || 'master'
      rescue StandardError
        'master'
      end

      private

      def read(config_name)
        unless defined? @config
          @config = YAML.safe_load(File.open(CONFIG_PATH))
        end
        @config[config_name]
      rescue StandardError
        @config = nil
      end
    end
  end
end
