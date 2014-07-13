require "ide_prefs/entities/pref"

module IdePrefs::Entities
  describe Pref do
    context "non-nil id" do
      it "is equal to another pref with the same non-nil id" do
        expect(Pref.new(id: 1)).to eq Pref.new(id: 1)
      end
    end

    context "nil id" do
      it "is not equal to any other pref" do
        expect(Pref.new(id: nil)).not_to eq Pref.new(id: nil)
      end
    end
  end
end
