module IdePrefs
  module Commands
    class InstallPrefs
      def initialize(user_prefs_repo: nil, pivotal_prefs_repo: nil, backup_prefs_repo: nil)
        @user_prefs_repo = user_prefs_repo
        @pivotal_prefs_repo = pivotal_prefs_repo
        @backup_prefs_repo = backup_prefs_repo
      end

      def execute
        back_up_user_prefs
        install_pivotal_prefs
      end

      private
      attr_reader(
        :pivotal_prefs_repo,
        :user_prefs_repo,
        :backup_prefs_repo,
      )

      def back_up_user_prefs
        existing_prefs = user_prefs_repo.find_matching_uninstalled_prefs(pivotal_prefs_repo.all)
        backup_prefs_repo.back_up_prefs(existing_prefs)
      end

      def install_pivotal_prefs
        user_prefs_repo.install_prefs(pivotal_prefs_repo.all)
      end
    end
  end
end
