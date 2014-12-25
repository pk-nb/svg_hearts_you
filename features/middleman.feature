Feature: SvgHeartsYou gem in a middleman app

  Scenario: Configuring gem with SvgHeartsYou config block
    Given the Server is running at "middleman-svg_hearts_you-config-style"
    When I go to "/index.html"
    Then I should see "<svg"
    Then reset SvgHeartsYou configuration

  Scenario: Configuring gem with Middleman extension
    Given the Server is running at "middleman-extension-config-style"
    When I go to "/index.html"
    Then I should see "<svg"
    Then reset SvgHeartsYou configuration
