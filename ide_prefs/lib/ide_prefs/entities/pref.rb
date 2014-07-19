require "ide_prefs/entities"

class IdePrefs::Entities::Pref
  attr_reader(
    :id,
    :location,
    :contents,
  )

  def initialize(id: nil, location: nil, contents: nil)
    @id = id
    @location = location
    @contents = contents
  end

  def ==(other_pref)
    return false if id.nil?

    id == other_pref.id
  end
end
