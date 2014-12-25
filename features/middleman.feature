Feature: SvgHeartsYou gem in a middleman app

  Scenario: helpers with defaults
    Given the Server is running at "middleman-app"
    When I go to "/index.html"
    Then I should see "<svg"
