Feature: Main tests
  In order to make sure that the web page is working
  As a normal user
  I want to check out the text on the home page

  @desktop
  Scenario: Visit ICC home page
    Given I am on the home page
    Then I must see the text "Digital has changed the game. Are you ready?" displayed
