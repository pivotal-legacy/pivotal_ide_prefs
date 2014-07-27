module Cli
  module Ide
    class Intellij
      def user_prefs_repo_location
        File.expand_path(File.join("~", "Library", "Preferences", "IntelliJIdea13"))
      end
    end
  end
end
