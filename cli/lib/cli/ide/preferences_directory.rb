module Cli
  module Ide
    class PreferencesDirectory
      def initialize(directories: [], match_pattern: nil, default: nil)
        @match_pattern = match_pattern
        @directories = directories
        @default = default
      end

      def to_s
        latest_version_of_preferences_directory || default
      end

      private
      attr_reader(
        :match_pattern,
        :directories,
        :default,
      )


      def latest_version_of_preferences_directory
        matching_directories.sort do |a, b|
          version_number_of_directory(a) <=> version_number_of_directory(b)
        end.last
      end

      def matching_directories
        directories.select { |dir| match_pattern.match(dir) }
      end

      def version_number_of_directory(dir)
        dir.split('/').last.gsub(/[a-zA-Z]/, "").to_f
      end
    end
  end
end
