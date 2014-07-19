require "ide_prefs/entities/pref"
require "persistence/private/file_database"

module Persistence
  module Repos
    class UserPrefsRepo
      def initialize(location: nil)
        @file_database = Persistence::Private::FileDatabase.new(location: location)
      end

      def put(pref)
        file_database.create_file(pref.id)
      end

      def install_prefs(prefs)
        prefs.each do |pref|
          file_database.symlink(pref.id, pref.location)
        end
      end

      def create_prefs(prefs)
        prefs.each do |pref|
          put(pref)
        end
      end

      def config
        { location: file_database.location }
      end

      def find_matching_prefs(prefs_to_match)
        prefs_to_match_relative_paths = prefs_to_match.collect(&:id)

        convert_files_to_prefs file_database.files_matching_relative_paths(prefs_to_match_relative_paths)
      end

      def all
        convert_files_to_prefs file_database.all
      end

      def installed_prefs
        convert_files_to_prefs file_database.symlinks
      end

      private
      attr_reader(
        :file_database,
      )

      def convert_files_to_prefs(files)
        files.map do |file|
          IdePrefs::Entities::Pref.new(
            id: file.relative_path,
            location: file.absolute_path,
          )
        end
      end
    end
  end
end
