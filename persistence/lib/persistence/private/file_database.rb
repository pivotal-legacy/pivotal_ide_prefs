require "fileutils"
require "tmpdir"

module Persistence
  module Private
    class FileDatabase
      attr_reader :location

      def initialize(location: nil)
        @location = location || Dir.mktmpdir
      end

      def create_file(relative_path)
        path_to_pref = File.join(location, relative_path)
        dir_of_pref = path_to_pref.split(separator)[0...-1].join(separator)

        FileUtils.mkdir_p(dir_of_pref)
        FileUtils.touch(path_to_pref)
      end

      def files_matching_relative_paths(relative_paths_to_match)
        all.select do |file|
          relative_paths_to_match.include?(file.relative_path)
        end
      end

      def all
        relative_paths.map do |relative_path|
          DatabaseFile.new(
            relative_path: relative_path,
            absolute_path: File.join(location, relative_path)
          )
        end
      end

      private

      def relative_paths
        all_files_in_repo.map do |file_path|
          file_path.sub(File.join(location, separator), "")
        end
      end

      def separator
        File::SEPARATOR
      end

      def all_files_in_repo
        Dir[File.join(location, "**", "*")]
      end

      class DatabaseFile
        attr_reader(
          :absolute_path,
          :relative_path,
        )

        def initialize(relative_path: nil, absolute_path: nil)
          @relative_path = relative_path
          @absolute_path = absolute_path
        end
      end
    end
  end
end
