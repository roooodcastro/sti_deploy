# frozen_string_literal: true

module StiDeploy
  class Version
    class ReleaseCandidate < VersionBumper
      def bump
        version.minor += 1 if version.rc.zero?
        version.hotfix = 0
        version.pre = 0
        version.rc += 1
      end
    end
  end
end
