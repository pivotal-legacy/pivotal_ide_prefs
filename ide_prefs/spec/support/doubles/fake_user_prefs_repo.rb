module Spec
  module Support
    module Doubles
      class FakeUserPrefsRepo
        attr_reader(
          :installed_prefs,
        )

        def initialize
          @prefs = []
          @installed_prefs = []
        end

        def uninstalled_prefs
          @prefs
        end

        def all
          @prefs + @installed_prefs
        end

        def copy(pref)
          @prefs << pref
        end

        def find_matching_uninstalled_prefs(match_against)
          @prefs.select {|p| match_against.include? p }
        end

        def install_prefs(prefs)
          prefs.each do |pref|
            @installed_prefs << pref unless @installed_prefs.include?(pref)
          end
        end

        def copy_prefs(prefs)
          @prefs += prefs
        end

        def destroy_installed_prefs
          @installed_prefs = []
        end
      end
    end
  end
end
