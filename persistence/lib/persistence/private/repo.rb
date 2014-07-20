module Persistence
  module Private
    class Repo
      attr_reader(
        :location,
      )

      def initialize(location: nil)
        @file_database = Persistence::Private::FileDatabase.new(location: location)
      end

      def copy(pref)
        file_database.copy_file(pref.id, pref.location)
      end

      def config
        {location: file_database.location}
      end

      def all
        convert_files_to_prefs file_database.all
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
            content_fetcher: -> { file.contents },
          )
        end
      end
    end
  end
end
