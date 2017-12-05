# frozen_string_literal: true

module StiDeploy
  class Deploy
    attr_reader :version, :type, :message, :git_user

    def initialize
      @version = Version.load_version
      @git_user = Configuration.git_username
    end

    def update_version!
      version.bump(read_type)
      version.update_file!
    end

    def commit_merge_and_tag!
      git_commit!
      git_merge!
      git_tag!
    end

    private

    def read_type
      Messages.print('deploy_type.prompt')
      type = gets.chomp
      return @type = DeployType.new(type) if %w[f F h H p P].include? type
      Messages.puts('deploy_type.invalid')
      read_type
    end

    def read_release_message
      Messages.print('release_message.prompt')
      msg = gets.chomp
      return @message = msg if msg.size >= 10
      Messages.puts('release_message.invalid')
      read_release_message
    end

    def git_commit!
      read_release_message
      Git.add_version
      Git.commit(message: commit_message)
      Git.push(branch: Configuration.origin_branch(type))
    end

    def git_merge!
      Git.checkout(branch: Configuration.target_branch(type))
      Git.pull(branch:     Configuration.target_branch(type))
      Git.merge(branch:    Configuration.origin_branch(type))
      Git.push(branch:     Configuration.target_branch(type))
      Git.checkout(branch: Configuration.origin_branch(type))
    end

    def git_tag!
      Git.tag(version: version.to_s, message: message)
      Git.push_tags
    end

    def commit_message
      by = I18n.t('messages.git.by')
      preparing = I18n.t('messages.git.preparing')
      return "#{preparing} #{message}" if git_user.nil? || git_user.empty?
      "#{by} #{git_user}: #{preparing} #{message}"
    end
  end
end
