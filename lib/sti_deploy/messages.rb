require 'i18n'
require 'colorize'

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
        super colorized_message(i18n_key, options)
      end

      def print(i18n_key, options = {})
        super colorized_message(i18n_key, options)
      end

      private

      def colorized_message(i18n_key, options)
        color = options.delete(:color)
        message = I18n.t("messages.#{i18n_key}", options)
        return message unless color
        message.colorize(color)
      end
    end
  end
end
