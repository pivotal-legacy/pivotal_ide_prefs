Feature: User error handling

  Scenario: Unknown command specified
    Given an unknown command is specified
    Then the CLI should gracefully alert the user before exiting
