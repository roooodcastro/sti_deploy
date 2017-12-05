require 'pathname'

require_relative 'sti_deploy/configuration'
require_relative 'sti_deploy/messages'
require_relative 'sti_deploy/version'
require_relative 'sti_deploy/git'
require_relative 'sti_deploy/deploy'

module StiDeploy
  class << self
    def begin_sti_deploy
      Messages.load_messages
      deploy = Deploy.new
      deploy.update_version!
      deploy.commit_merge_and_tag!
    end
  end
end
