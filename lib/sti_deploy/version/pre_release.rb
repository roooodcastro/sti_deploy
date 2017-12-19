# frozen_string_literal: true

module StiDeploy
  class Version
    class PreRelease < VersionBumper
      def bump
        version.minor += 1 if version.pre.zero?
        version.hotfix = 0
        version.pre += 1
        version.rc = 0
      end
    end
  end
end
