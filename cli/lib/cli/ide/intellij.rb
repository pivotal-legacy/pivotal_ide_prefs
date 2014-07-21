module Cli
  module Ide
    class Intellij
      def locations
        {
          user_prefs_repo:    File.expand_path(File.join("~", "Library", "Preferences", "IntelliJIdea13")),
          pivotal_prefs_repo: File.expand_path(File.join(__dir__, "..", "..", "..", "..", "pref_sources", "IntelliJ")),
        }
      end
    end
  end
end
