Feature: You are able to see a list of all categories

  Background:
    * url baseURL
    * configure headers = ({ 'X-API-Key' : apiKey })

  Scenario: Categories returns a list of all categories
    Given path 'categories'
    And method get
    Then match each response == categoriesSchema