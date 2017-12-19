# frozen_string_literal: true

module StiDeploy
  class Git
    attr_reader :version, :deploy_type

    class << self
      def add_version
        `git add #{Configuration.version_path}`
      end

      def commit(message: '')
        `git commit -m "#{message.tr('"', '\"')}"`.zero?
      end

      def checkout(branch: 'master')
        `git checkout #{branch}`.zero?
      end

      def merge(branch: 'master')
        `git merge #{branch}`.zero?
      end

      def tag(version: '', message: '')
        `git tag -a v#{version.to_s} -m "#{message.tr('"', '\"')}"`.zero?
      end

      def pull(branch: 'master', remote: 'origin')
        `git pull #{remote} #{branch}`.zero?
      end

      def push(branch: 'master', remote: 'origin')
        `git push #{remote} #{branch}`.zero?
      end

      def push_tags
        `git push --tags`.zero?
      end
    end

    def initialize(version, deploy_type)
      @version = version
      @deploy_type = deploy_type
    end

    def commit_merge_and_tag!(message)
      commit!(message)
      merge!
      tag!(message)
    end

    def commit!(message)
      Git::Commit.new(commit_branch, message).commit!
    end

    def merge!
      merge_branches.each do |target_branch|
        Git::Merge.new(commit_branch, target_branch).merge!
      end
    end

    def tag!(message)
      Messages.puts('git.tagging', color: :yellow)
      Git.tag(version: version.to_s, message: message)
      Git.push_tags
    end

    def commit_branch
      Configuration.commit_branch(deploy_type)
    end

    # Can be more than one branch, example: merge staging to production and
    # hotfix, to synchronize production with hotfix and staging.
    def merge_branches
      Array(Configuration.merge_branch(deploy_type))
    end
  end
end
