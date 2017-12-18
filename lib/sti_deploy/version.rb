# frozen_string_literal: true

module StiDeploy
  class Version
    attr_accessor :major, :minor, :hotfix, :rc, :pre

    FULL_VERSION_REGEX = /[\d]+.[\d]+.[\d]+(rc[\d]+)?(pre[\d]+)?/

    class << self
      def load_version
        validate_version_file
        version = read_current_version
        validate_version(version)
        Messages.puts('version.detected', version: version, color: :green)
        version
      end

      private

      def validate_version_file
        return true if File.file?(Configuration.version_path)
        Messages.puts('version.file_not_found',
                      path: Configuration.version_path, color: :red)
        exit(-1)
      end

      def read_current_version
        File.open(Configuration.version_path).each do |line|
          version = line[FULL_VERSION_REGEX]
          return Version.new(version.tr('\'"', '')) if version
        end
      end

      def validate_version(version)
        return true if version && !version.is_a?(File)
        Messages.puts('version.not_found', path: Configuration.version_path,
                      color: :red)
        exit(-2)
      end
    end

    def initialize(version)
      @major, @minor, @hotfix = version[/[\d]+.[\d]+.[\d]+/].split('.')
                                  .map(&:to_i)
      self.rc = version[/rc[\d]+/].to_s.tr('rc', '').to_i
      self.pre = version[/pre[\d]+/].to_s.tr('pre', '').to_i
    end

    def bump(deploy_type)
      old = to_s
      send("bump_#{deploy_type}")
      Messages.puts('version.increment', old: old, new: to_s, color: :green)
      to_s
    end

    def update_file!
      version_file = File.read(Configuration.version_path)
      new_version = version_file.gsub(FULL_VERSION_REGEX, to_s)
      File.open(Configuration.version_path, 'w') { |f| f.puts new_version }
    end

    def to_s
      base = "#{major}.#{minor}.#{hotfix}"
      base += "rc#{rc}" if rc > 0
      base += "pre#{pre}" if pre > 0
      base
    end

    private

    # Bump hot(f)ix
    def bump_f
      self.hotfix += 1
    end

    # Bump (h)omologação
    def bump_h
      self.minor += 1 if rc.zero? # Se ainda não existir RC, dá bump no minor
      self.hotfix = 0
      self.rc += 1
    end

    # Bump (p)rojeto
    def bump_p
      self.minor += 1 if pre.zero? # Se ainda não existir PRE, dá bump no minor
      self.hotfix = 0
      self.pre += 1
    end

    # Bump (r)release
    def bump_r
      # Se ainda não estiver em PRE nem RC, da bump no minor
      self.minor += 1 if pre.zero? && rc.zero?
      self.hotfix = 0
      self.pre = 0
      self.rc = 0
    end
  end
end
