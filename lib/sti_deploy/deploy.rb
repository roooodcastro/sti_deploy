# frozen_string_literal: true

module StiDeploy
  class Deploy
    attr_reader :version, :type

    def initialize
      @version = Version.load_version
    end

    def update_version!
      version.bump(read_type)
      version.update_file!
      Messages.puts('version.increment', old: version.old, new: version.to_s,
                    color: :green)
    end

    def commit_merge_and_tag!
      Git.new(version, type).commit_merge_and_tag!(read_release_message)
    end

    private

    def read_type
      Messages.print('deploy_type.prompt')
      type = gets.chomp
      return @type = DeployType.new(type) if %w[c C h H p P r R].include? type
      Messages.puts('deploy_type.invalid')
      read_type
    end

    def read_release_message
      Messages.print('release_message.prompt')
      msg = gets.chomp
      return msg if msg.size >= 10
      Messages.puts('release_message.invalid')
      read_release_message
    end
  end
end
