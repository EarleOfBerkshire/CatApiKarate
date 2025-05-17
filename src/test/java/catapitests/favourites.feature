Feature: You are able to add, view and remove favourites on images

  Background:
    * url baseURL
    * configure headers = ({ 'X-API-Key' : apiKey })

  Scenario: Calling Votes returns a list of all votes
    Given path 'favourites'
    And method get
    Then status 200
    And match each response == favouriteSchema


  Scenario: Favourites/:favouriteid returns the details of the specific vote
    Given path 'favourites'
    And method get
    * def favouriteId = response[0].id
    Given path 'favourites/',favouriteId
    And method get
    Then status 200
    And match response.id == favouriteId
    Then match response == favouriteSchema


  Scenario: Adding a favourite is correctly recorded
    Given path 'favourites'
    When request {"image_id":'#(testImageId)' }
    And method post
    Then status 200
    And response.message =='SUCCESS'
    * def myNewFavouriteId = response.id
    Given path 'favourites/',myNewFavouriteId
    And method get
    Then status 200
    And match response.id == myNewFavouriteId
    And match response.image_id == testImageId


  Scenario: Deleting a favourite removes the vote from the api and it can no longer be retrieved
    Given path 'favourites'
    When request {"image_id":'#(testImageId)' }
    And method post
    Then status 200
    And response.message =='SUCCESS'
    * def myNewFavouriteId = response.id
    Given path 'favourites/',myNewFavouriteId
    And method delete
    Then status 200
    And match response.message == 'SUCCESS'
    Given path 'favourites/',myNewFavouriteId
    And method get
    Then status 404