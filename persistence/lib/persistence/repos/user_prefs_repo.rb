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

      def config
        { location: file_database.location }
      end

      def find_matching_prefs(prefs_to_match)
        prefs_to_match_relative_paths = prefs_to_match.collect(&:id)

        file_database.files_matching_relative_paths(prefs_to_match_relative_paths).map do |file|
          IdePrefs::Entities::Pref.new(
            id: file.relative_path,
            location: file.absolute_path,
          )
        end
      end

      private
      attr_reader(
        :file_database,
      )
    end
  end
end
