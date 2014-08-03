Feature: Install Prefs

  Scenario: Prefs not already installed
    Given that the user has not already installed any prefs
    When the user installs prefs
    Then the prefs should be installed
