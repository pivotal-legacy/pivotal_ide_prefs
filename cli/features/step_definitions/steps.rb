Given(/^that the user has not already installed any prefs$/) do
  system "rm -rf tmp/"
end

When(/^the user installs rubymine prefs$/) do
  @backup_prefs_location = `mktemp -d /tmp/backup.XXXXXXXX`.strip
  system "bin/ide_prefs --ide rubymine --backup-prefs-location=#{@backup_prefs_location} --user-prefs-location tmp/RubyminePrefs install 2>&1"
end

Then(/^the prefs should be installed$/) do
  expect(Dir.entries("tmp/RubyminePrefs").size).to be > 2
end


Given(/^that the user has no prefs$/) do
  system "rm -rf tmp/"
end

And(/^then uninstalls the prefs$/) do
  system "bin/ide_prefs --ide rubymine --backup-prefs-location=#{@backup_prefs_location} --user-prefs-location tmp/RubyminePrefs uninstall 2>&1"
end

Then(/^the user should not have any prefs$/) do
  files = Dir.glob("tmp/RubyminePrefs/**/*").select{|path| File.file?(path)}
  expect(files).to be_empty
end
