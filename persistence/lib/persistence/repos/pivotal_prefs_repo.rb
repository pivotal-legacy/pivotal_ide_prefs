require "ide_prefs/entities/pref"
require "persistence/private/file_database"

module Persistence
  module Repos
    class PivotalPrefsRepo
      attr_reader(
        :location,
      )

      def initialize(location: Dir.mktmpdir)
        @location = location
        @file_database = Persistence::Private::FileDatabase.new(location: location)
      end

      def put(pref)
        file_database.create_file(pref.id)
      end

      def all
        file_database.all.map do |file|
          IdePrefs::Entities::Pref.new(
            id: file.relative_path,
            location: file.absolute_path,
          )
        end
      end

      private
      attr_reader :file_database
    end
  end
end
