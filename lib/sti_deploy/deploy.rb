module StiDeploy
  class Deploy
    attr_reader :version, :type, :message, :git_user

    def initialize
      @version = Version.load_version
      @git_user = Configuration.git_username
    end

    def update_version!
      version.bump(read_type)
      puts type
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
      return @type = type.downcase if %w(f F h H p P).include? type
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
      preparing = I18n.t('messages.git.preparing')
      Git.add_version
      Git.commit(message: "por #{git_user}: #{preparing} #{message}")
      Git.push(branch: Git.origin_branch(deploy_type: type))
    end

    def git_merge!
      Git.checkout(branch: Git.target_branch(deploy_type: type))
      Git.pull(branch: Git.target_branch(deploy_type: type))
      Git.merge(deploy_type: type)
      Git.push(branch: Git.target_branch(deploy_type: type))
      Git.checkout(branch: Git.origin_branch(deploy_type: type))
    end

    def git_tag!
      Git.tag(version: version.to_s, message: message)
      Git.push_tags
    end
  end
end
