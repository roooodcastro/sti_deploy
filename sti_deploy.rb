require 'pathname'

require_relative 'lib/configuration'
require_relative 'lib/messages'
require_relative 'lib/version'
require_relative 'lib/git'
require_relative 'lib/deploy'

class StiDeploy
  class << self
    def begin_sti_deploy
      Messages.load_messages
      deploy = Deploy.new
      deploy.update_version!
      deploy.commit_merge_and_tag!
    end
  end
end
