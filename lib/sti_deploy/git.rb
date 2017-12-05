module StiDeploy
  class Git
    class << self
      def add_version
        `git add #{Configuration.version_path}`
        # puts "git add #{Configuration.version_path}"
      end

      def commit(message: '')
        `git commit -m "#{message.tr('"', '\"')}"`
        # puts "git commit -m \"#{message.tr('"', '\"')}\""
      end

      def checkout(branch: 'master')
        `git checkout #{branch}`
        # puts "git checkout #{branch}"
      end

      def merge(deploy_type: 'f')
        `git merge #{origin_branch(deploy_type: deploy_type)}`
        # puts "git merge #{origin_branch(deploy_type: deploy_type)}"
      end

      def tag(version: '', message: '')
        `git tag -a v#{version.to_s} -m "#{message.tr('"', '\"')}"`
        # puts "git tag -a v#{version.to_s} -m \"#{message.tr('"', '\"')}\""
      end

      def pull(branch: 'master', remote: 'origin')
        `git pull #{remote} #{branch}`
        # puts "git pull #{remote} #{branch}"
      end

      def push(branch: 'master', remote: 'origin')
        `git push #{remote} #{branch}`
        # puts "git push #{remote} #{branch}"
      end

      def push_tags
        `git push --tags`
        # puts 'git push --tags'
      end

      def origin_branch(deploy_type: 'f')
        deploy_type == 'f' ? 'hotfix' : 'master'
      end

      def target_branch(deploy_type: 'f')
        deploy_type == 'f' ? 'producao' : 'homologacao'
      end
    end
  end
end
