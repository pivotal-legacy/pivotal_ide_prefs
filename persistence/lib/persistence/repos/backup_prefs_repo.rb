require "ide_prefs/entities/pref"
require "persistence/private/file_database"
require "persistence/private/repo"

module Persistence
  module Repos
    class BackupPrefsRepo < Private::Repo
      def back_up_prefs(prefs)
        prefs.each do |pref|
          copy(pref)
        end
      end
    end
  end
end
