module Cli
  module Ide
    class Rubymine
      def user_prefs_repo_location
        File.expand_path(File.join("~", "Library", "Preferences", "RubyMine60"))
      end
    end
  end
end
