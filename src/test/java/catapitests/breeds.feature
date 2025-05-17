Feature: You are able to display a list of all or an details of an individual breed

  Background:
    * url baseURL
    * configure headers = ({ 'X-API-Key' : apiKey })

  Scenario: Breeds returns a list of all sources
    Given path 'breeds'
    And method get
    Then match each response == breedSchema


  Scenario: Calling breeds/:breed_id returns details of the requested breed id
    Given path 'breeds'
    And method get
    * def breedId = response[0].id
    Given path 'breeds/',breedId
    And method get
    Then match response.id == breedId
    Then match response == breedSchema