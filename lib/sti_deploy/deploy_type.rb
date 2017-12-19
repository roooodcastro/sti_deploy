# frozen_string_literal: true

module StiDeploy
  class DeployType
    attr_reader :type

    DEPLOY_TYPES = {
      c: 'release_candidate',
      h: 'hotfix',
      p: 'pre_release',
      r: 'release'
    }

    def initialize(type)
      @type = type.downcase
    end

    def full_name
      DEPLOY_TYPES[type.to_sym]
    end

    def to_s
      full_name
    end
  end
end
