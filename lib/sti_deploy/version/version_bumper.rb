module StiDeploy
  class Version
    class VersionBumper
      attr_reader :version

      # We use eval here because the only possible strings that will be
      # evaluated live in a hardcoded hash inside StiDeploy::DeployType.
      #
      # rubocop:disable Security/Eval
      def self.from_deploy_type(deploy_type, version)
        class_name = deploy_type.to_s.split('_').map(&:capitalize).join
        klass = eval("StiDeploy::Version::#{class_name}")
        klass.new(version)
      end
      # rubocop:enable Security/Eval

      def initialize(version)
        @version = version
      end

      def bump; end
    end
  end
end
