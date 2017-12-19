# frozen_string_literal: true

module StiDeploy
  class Version
    class Hotfix < VersionBumper
      def bump
        version.hotfix += 1
        version.pre = 0
        version.rc = 0
      end
    end
  end
end
