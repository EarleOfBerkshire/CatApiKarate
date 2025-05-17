Feature: You are able to view the list of sources

  Background:
    * url baseURL
    * configure headers = ({ 'X-API-Key' : apiKey })

  Scenario: Sources returns a list of all sources
    Given path 'sources'
    And method get
    Then match each response == sourceSchema