require 'yaml'

class Configuration
  CONFIG_PATH = File.expand_path(File.join(__dir__, '../', '/config.yml'))

  class << self
    private

    def read(config_name)
      YAML::load(File.open(CONFIG_PATH))[config_name]
    end
  end

  def self.version_path
    read('version_path')
  end

  def self.language
    read('language')
  end

  def self.git_username
    read('git_username')
  end
end