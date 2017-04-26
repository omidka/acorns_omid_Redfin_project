Feature:Testing Redfin

  Scenario:Testing Redfin Logging in

    Given I navigate to Redfin
    When User logs in to Redfin
    Then Verify user is logged in
    Then Search for a property in a city
    When Narrow down the filters to find my property
    Then Make sure the results are correct
