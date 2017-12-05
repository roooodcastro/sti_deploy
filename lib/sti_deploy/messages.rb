require 'i18n'

module StiDeploy
  class Messages
    LANG_PATH = File.expand_path(File.join(__dir__, '../../', 'lang/', '*.yml'))

    class << self
      # Load the translation files and set the configured language
      def load_messages
        I18n.load_path = Dir[LANG_PATH]
        I18n.backend.load_translations
        I18n.default_locale = :en
        I18n.locale = Configuration.language
      end

      def puts(i18n_key, options = {})
        super I18n.t("messages.#{i18n_key}", options)
      end

      def print(i18n_key, options = {})
        super I18n.t("messages.#{i18n_key}", options)
      end
    end
  end
end
