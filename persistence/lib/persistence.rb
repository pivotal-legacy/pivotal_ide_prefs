Dir[File.join(__dir__, "persistence", "**", "*.rb")].each do |file|
  require file
end
