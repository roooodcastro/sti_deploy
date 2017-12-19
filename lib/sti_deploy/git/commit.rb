module StiDeploy
  class Git
    class Commit
      attr_reader :branch, :git_user, :message

      def initialize(branch, message)
        @branch = branch
        @git_user = Configuration.git_username
        @message = commit_message(git_user, message)
      end

      def commit!
        Messages.puts('git.committing', color: :yellow)
        Git.add_version
        return true if Git.commit(message: message) && Git.push(branch: origin)
        Messages.puts('git.push_error', target: origin, color: :red)
        exit(4)
      end

      private

      def commit_message(git_user, message)
        by = I18n.t('messages.git.by')
        preparing = I18n.t('messages.git.preparing')
        return "#{preparing} #{message}" if git_user.nil? || git_user.empty?
        "#{by} #{git_user}: #{preparing} #{message}"
      end
    end
  end
end
