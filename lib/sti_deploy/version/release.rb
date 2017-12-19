# frozen_string_literal: true

module StiDeploy
  class Version
    class Release < VersionBumper
      def bump
        version.minor += 1 if version.pre.zero? && version.rc.zero?
        version.hotfix = 0
        version.pre = 0
        version.rc = 0
      end
    end
  end
end
