Feature: Uninstall Prefs

  Scenario: Prefs not already installed
    Given that the user has no prefs
    When the user installs prefs
    And then uninstalls the prefs
    Then the user should not have any prefs
