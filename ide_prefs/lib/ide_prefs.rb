module IdePrefs
end

Dir[File.join(__dir__, "ide_prefs", "**", "*.rb")].each do |file|
  require file
end
