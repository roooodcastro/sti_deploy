# Generator para configurar a gem na aplicação host.

require 'sti_deploy/messages'

module StiDeploy
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc <<DESC
Description:
  - Copies the configuration file to the root of the project
  - Configures the username, branches and languages
  - Adds the new configuration file to the .gitignore file
DESC

    def copy_install_file
      copy_file('sti_deploy.yml', 'sti_deploy.yml')
    end

    def set_language
      language = choose_language
      if language
        I18n.locale = language
        replace_in_file('sti_deploy.yml', '<LANG>', language)
        StiDeploy::Messages.load_messages
        StiDeploy::Messages.puts('generator.language_chosen', color: :green)
      else
        puts 'Invalid option. Please choose a valid option!'
        set_language
      end
    end

    def set_username
      replace_in_file('sti_deploy.yml', '<USERNAME>', choose_username.strip)
      StiDeploy::Messages.puts('generator.username_chosen', color: :green)
    end

    def add_file_to_gitignore
      return if file_not_found('.gitignore')
      ignore_lines_sti_deploy = File.readlines('.gitignore').map do |line|
        line.include?('sti_deploy.yml')
      end
      if ignore_lines_sti_deploy.any?
        StiDeploy::Messages.puts('generator.gitignore_skipped', color: :yellow)
      else
        append_to_file '.gitignore', "sti_deploy.yml\n"
        StiDeploy::Messages.puts('generator.gitignore_updated', color: :green)
      end
    end

    def finish_install
      StiDeploy::Messages.puts('generator.finish', color: :light_blue)
    end

    protected

    def file_not_found(file, say_if_not_found = true)
      unless File.exists?(file)
        msg = "#{file} not found, configure manually"
        shell.say_status('not found', msg, :red) if say_if_not_found
        return true
      end
      false
    end

    def choose_language
      puts 'Which language do you prefer?'
      I18n.available_locales.each_with_index do |locale, index|
        puts "  #{index + 1}: #{locale}"
      end
      print '> '
      choice = gets
      options_array = I18n.available_locales.size.times.map { |i| i + 1 }
      return nil unless options_array.include?(choice.to_i)
      I18n.available_locales[choice.to_i - 1]
    end

    def choose_username
      StiDeploy::Messages.puts('generator.username_prompt')
      print '> '
      gets
    end

    def replace_in_file(file_name, from, to)
      contents = File.read(file_name)
      new_contents = contents.gsub(from, to.to_s)
      File.open(file_name, 'w') { |file| file.puts new_contents }
    end
  end
end
