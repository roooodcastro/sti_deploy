require 'pathname'

require_relative 'sti_deploy/configuration'
require_relative 'sti_deploy/messages'
require_relative 'sti_deploy/version'
require_relative 'sti_deploy/git'
require_relative 'sti_deploy/deploy_type'
require_relative 'sti_deploy/deploy'

# Program exit codes:
#
# -3: Error: Program was interrupted (CTRL+C)
# -2: Error: Version file was not found
# -1: Error: A valid version number within the version file was not found
#  0: Program exited successfully

module StiDeploy
  class << self
    def begin_sti_deploy
      Messages.load_messages
      deploy = Deploy.new
      deploy.update_version!
      deploy.commit_merge_and_tag!
    rescue Interrupt
      Messages.puts 'system.interrupted', color: :red
      exit(-3)
    end
  end
end
