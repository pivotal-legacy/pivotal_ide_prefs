World Acceptance::Helpers

Given(/^that the user has not already installed any prefs$/) do
  user_preferences.destroy
end

When(/^the user installs prefs$/) do
  cli.install_prefs
end

Then(/^the prefs should be installed$/) do
  expect(user_preferences).to be_present
end

Given(/^that the user has no prefs$/) do
  user_preferences.destroy
end

And(/^then uninstalls the prefs$/) do
  cli.uninstall_prefs
end

Then(/^the user should not have any prefs$/) do
  expect(user_preferences).not_to be_present
end

Given(/^an unknown command is specified$/) do
  cli.run("non_existant_command")
end

Then(/^the CLI should gracefully alert the user before exiting$/) do
  expect(cli.last_command_run).to have_failed
  expect(cli.last_command_run).not_to have_stacktrace
end
