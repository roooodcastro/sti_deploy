module StiDeploy
  class Git
    class << self
      def add_version
        `git add #{Configuration.version_path}`
      end

      def commit(message: '')
        `git commit -m "#{message.tr('"', '\"')}"`
      end

      def checkout(branch: 'master')
        `git checkout #{branch}`
      end

      def merge(branch: 'master')
        `git merge #{branch}`
      end

      def tag(version: '', message: '')
        `git tag -a v#{version.to_s} -m "#{message.tr('"', '\"')}"`
      end

      def pull(branch: 'master', remote: 'origin')
        `git pull #{remote} #{branch}`
      end

      def push(branch: 'master', remote: 'origin')
        `git push #{remote} #{branch}`
      end

      def push_tags
        `git push --tags`
      end
    end
  end
end
