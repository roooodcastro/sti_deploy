module StiDeploy
  class Git
    class Merge
      attr_reader :origin, :target

      def initialize(origin_branch, target_branch)
        @origin = origin_branch
        @target = target_branch
      end

      def merge!
        return unless needs_merge?
        Messages.puts('git.merging', origin: origin, target: target,
                      color: :yellow)
        update_target_branch! && try_merge! && finalize_merge!
      end

      private

      # Makes sure the branch is updated
      def update_target_branch!
        return true if Git.checkout(branch: target) && Git.pull(branch: target)
        Messages.puts('git.pull_error', origin: origin_branch, color: :red)
        exit(4)
      end

      def try_merge!
        return true if Git.merge(branch: origin)
        Messages.puts('git.merge_error', origin: origin_branch,
                      target: target_branch, color: :red)
        exit(4)
      end

      def finalize_merge!
        return true if Git.push(branch: target) && Git.checkout(branch: origin)
        Messages.puts('git.push_error', target: target_branch, color: :red)
        exit(4)
      end

      # It only needs to merge if the origin branch is different from the
      # target branch (no need to merge to the same branch).
      def needs_merge?
        origin_branch.to_s != target_branch.to_s
      end
    end
  end
end
