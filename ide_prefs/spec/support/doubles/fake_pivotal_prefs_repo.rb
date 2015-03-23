module Spec
  module Support
    module Doubles
      class FakePivotalPrefsRepo
        attr_reader :all

        def initialize
          @all = []
        end

        def copy(pref)
          @all << pref
        end
      end
    end
  end
end
