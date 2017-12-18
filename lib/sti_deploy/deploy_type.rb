# frozen_string_literal: true

module StiDeploy
  class DeployType
    attr_reader :type

    def initialize(type)
      @type = type.downcase
    end

    def full_name
      { h: 'staging', f: 'hotfix', p: 'project', r: 'release' }[type.to_sym]
    end

    def to_s
      type
    end
  end
end
