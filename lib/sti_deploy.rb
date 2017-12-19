# frozen_string_literal: true

require 'pathname'

require_relative 'sti_deploy/configuration'
require_relative 'sti_deploy/messages'
require_relative 'sti_deploy/version'
require_relative 'sti_deploy/version/version_bumper'
require_relative 'sti_deploy/git'
require_relative 'sti_deploy/git/commit'
require_relative 'sti_deploy/git/merge'
require_relative 'sti_deploy/deploy_type'
require_relative 'sti_deploy/deploy'

Dir[__dir__ + '/sti_deploy/version/*.rb'].each { |file| require_relative(file) }
Dir[__dir__ + '/sti_deploy/deploy/*.rb'].each { |file| require_relative(file) }

# Program exit codes:
#
# 0: Program exited successfully
# 1: Error: A valid version number within the version file was not found
# 2: Error: Version file was not found
# 3: Error: Program was interrupted (CTRL+C)
# 4: Error: There was an error during the Git commit or merge process

module StiDeploy
  class << self
    def begin_sti_deploy
      Messages.load_messages
      deploy = Deploy.new
      deploy.update_version!
      deploy.commit_merge_and_tag!
      Messages.puts 'system.finished', color: :green
    rescue Interrupt
      Messages.puts 'system.interrupted', color: :red
      exit(3)
    end
  end
end
