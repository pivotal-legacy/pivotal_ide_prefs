module Acceptance
  module Helpers
    def cli
      @shell_operator ||= Features::IdePrefsCli.new
    end

    def user_preferences
      @user_preferences ||= Features::UserPreferences.new
    end
  end
end
