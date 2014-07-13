require "ide_prefs/entities/pref"
require "persistence/private/file_database"

module Persistence
  module Repos
    class BackupPrefsRepo
      def initialize(location: nil)
        @file_database = Persistence::Private::FileDatabase.new(location: location)
      end

      def config
        { location: file_database.location }
      end

      def back_up_prefs(prefs)
        prefs.each do |pref|
          copy(pref)
        end
      end

      def copy(pref)
        file_database.copy(pref.id, pref.location)
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
      attr_reader(
        :file_database,
      )
    end
  end
end
