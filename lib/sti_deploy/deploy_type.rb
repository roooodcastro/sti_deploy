module StiDeploy
  class DeployType
    attr_reader :type

    def initialize(type)
      @type = type.downcase
    end

    def full_name
      { h: 'staging', f: 'hotfix', p: 'project' }[type]
    end

    def to_s
      type
    end
  end
end
