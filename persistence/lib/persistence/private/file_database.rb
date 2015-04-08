require "fileutils"
require "tmpdir"

module Persistence
  module Private
    class FileDatabase
      attr_reader :location

      def initialize(location: nil)
        @location = location || Dir.mktmpdir
      end

      def copy_file(relative_path_in_database, absolute_path_of_original_file)
        absolute_path_for_new_file = absolute_path_in_database(relative_path_in_database)
        prepare_home_for_file(absolute_path_for_new_file)
        FileUtils.copy(absolute_path_of_original_file, absolute_path_for_new_file)
      end

      def destroy_file(relative_path)
        FileUtils.remove(absolute_path_in_database(relative_path))
      end

      def symlink(relative_path, absolute_path)
        abs_path_in_db_for_file = absolute_path_in_database(relative_path)
        prepare_home_for_file(abs_path_in_db_for_file)
        FileUtils.symlink(absolute_path, abs_path_in_db_for_file)
      end

      def regular_files_matching_relative_paths(paths)
        regular_files.select do |file|
          paths.include?(file.relative_path)
        end
      end

      def symlink_files_matching_relative_paths(paths)
        symlinks.select do |file|
          paths.include?(file.relative_path)
        end
      end

      def symlinks
        convert_relative_paths_to_file_objects relative_symlinks
      end

      def all
        convert_relative_paths_to_file_objects relative_paths
      end

      def regular_files
        all - symlinks
      end

      private

      def convert_relative_paths_to_file_objects(relative_paths)
        relative_paths.map do |relative_symlink|
          absolute_path = absolute_path_in_database(relative_symlink)

          DatabaseFile.new(
            relative_path: relative_symlink,
            absolute_path: absolute_path,
            content_fetcher: -> { File.read(absolute_path) },
          )
        end
      end

      def prepare_home_for_file(absolute_path_for_file)
        dir_of_pref = absolute_path_for_file.split(separator)[0...-1].join(separator)

        FileUtils.mkdir_p(dir_of_pref)
      end

      def absolute_path_in_database(relative_path)
        File.join(location, relative_path)
      end

      def relative_paths
        convert_absolute_paths_to_relative_paths all_files_in_repo
      end

      def relative_symlinks
        convert_absolute_paths_to_relative_paths all_symlinks_in_repo
      end

      def convert_absolute_paths_to_relative_paths(absolute_paths)
        absolute_paths.map do |file_path|
          file_path.sub(Regexp.new(absolute_path_in_database(separator), Regexp::IGNORECASE), "")
        end
      end

      def separator
        File::SEPARATOR
      end

      def all_files_in_repo
        all_entries_in_database.select { |file_or_dir| File.file?(file_or_dir) }
      end

      def all_symlinks_in_repo
        all_entries_in_database.select { |file_or_dir| File.symlink?(file_or_dir) }
      end

      def all_entries_in_database
        Dir[File.join(location, "**", "*")]
      end

      class DatabaseFile
        attr_reader(
          :absolute_path,
          :relative_path,
        )

        def initialize(relative_path: nil, absolute_path: nil, content_fetcher: ->{})
          @relative_path   = relative_path
          @absolute_path   = absolute_path
          @content_fetcher = content_fetcher
        end

        def contents
          @content_fetcher.call
        end

        def eql?(other_file)
          absolute_path == other_file.absolute_path
        end

        def hash
          absolute_path.hash
        end
      end
    end
  end
end
