module IdePrefs
  module Commands
    class UninstallPrefs
      def initialize(
        user_prefs_repo: nil,
        pivotal_prefs_repo: nil,
        backup_prefs_repo: nil
      )
        @user_prefs_repo = user_prefs_repo
        @pivotal_prefs_repo = pivotal_prefs_repo
        @backup_prefs_repo = backup_prefs_repo
      end

      def execute
        user_prefs_repo.destroy_installed_prefs
        user_prefs_repo.copy_prefs(backup_prefs_repo.all)
      end

      private
      attr_reader(
        :user_prefs_repo,
        :pivotal_prefs_repo,
        :backup_prefs_repo,
      )
    end
  end
end
