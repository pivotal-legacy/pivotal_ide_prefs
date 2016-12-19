module Acceptance
  module Features
    class IdePrefsCli
      def initialize
        @backup_prefs_location = `mktemp -d /tmp/backup.XXXXXXXX`.strip
      end

      def install_prefs
        run "install"
      end

      def uninstall_prefs
        run "uninstall"
      end

      def run(command_name)
        @last_command = Command.new(command_name: command_name, backup_prefs_location: backup_prefs_location)
        @last_command.run
      end

      def last_command_run
        @last_command
      end

      private
      attr_reader :backup_prefs_location

      class Command
        require "open3"

        def initialize(command_name: nil, backup_prefs_location: nil)
          @backup_prefs_location = backup_prefs_location
          @command_name = command_name
        end

        def run
          Bundler.with_clean_env do
            Dir.chdir '..' do
              Open3.popen3(
                "cli/bin/ide_prefs" +
                " --ide rubymine" +
                " --backup-prefs-location=#{backup_prefs_location}" +
                " --user-prefs-location cli/tmp/RubyminePrefs" +
                " #{command_name}"
              ) do |stdin, stdout, stderr, wait_thr|
                @exit_status = wait_thr.value
                @output = stdout.read.chomp + stderr.read.chomp
              end
            end
          end
        end

        def has_failed?
          !exit_status.success?
        end

        def has_stacktrace?
          output.match(/.*:\d+:in.*/)
        end

        private
        attr_reader(
          :exit_status,
          :backup_prefs_location,
          :command_name,
        )

        def output
          @output.to_s
        end
      end
    end
  end
end
