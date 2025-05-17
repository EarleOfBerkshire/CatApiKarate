Feature: Accessing the cat api without authorization limits some features

  Background:
    * url baseURL

  Scenario: Image search requests without an api key limit the number of results to 10
    Given path 'images/search'
    And param limit = 25
    When method get
    Then status 200
    And assert response.length == 10
  # Add api key to the header and verify number or results is more than 10
    Given path 'images/search'
    And header X-API-Key = apiKey
    And param limit = 25
    When method get
    Then status 200
    And assert response.length == 25


  Scenario: Image search requests with an api key set as a query parameter can return more than 10 results
    Given path 'images/search'
    And param  api_key = apiKey
    And param limit = 25
    When method get
    Then status 200
    And assert response.length == 25


  Scenario: Image search requests with a bogus api key are treated as unauthorised and limit number of results to 10
    Given path 'images/search'
    And param  api_key = 'bogus-api-key'
    And param limit = 25
    When method get
    Then status 200
    And assert response.length == 10

# The following scenario currently fails as api does not match authentiction documentation
#  Scenario: Jokes endpoint is only available with an api key
#    Given path '/jokes'
#    When method get
#    Then status 404
#    # Add api key and check endpoint is now reachable
#    Given path '/jokes'
#    Given param api_key = apiKey
#    When method get
#    Then status 200


# The following scenario currently fails as api does not match authentiction documentation
#  Scenario: Facts endpoint is only available with an api key
#    Given path '/facts'
#    When method get
#    Then status 404
#    # add api key and check endpoint is reachable
#    Given param api_key = apiKey
#    When method get
#    Then status 200


  Scenario: Cannot upload images via ./images/upload without an api key
    Given path 'images/upload'
    And header Content-Type = 'multipart/form-data'
    And multipart file file =  { read:'./mycat.jpg',  filename: 'mycat.jpg', contentType: 'image/jpeg' }
    When method post
    Then status 401
    And match response == "AUTHENTICATION_ERROR - you need to send your API Key as the 'x-api-key' header"


  Scenario: cannot save votes via the ./votes endpoint
    Given path 'votes'
    When request {"image_id":'#(testImageId)',"value":1 }
    And method post
    Then status 401


  Scenario: cannot save favourites via the ./favourites endpoint
    Given path 'favourites'
    When request {"image_id":"9ccXTANkb","sub_id":"your-user-1234"}
    And method post
    Then status 401


  Scenario: Supplying include_categories and include_breeds for ./images/search without api key does not return categories or breeds in response
    Given path 'images/search'
    And param include_categories = true
    And param category_ids = 1
    And param include_breeds = true
    And method get
    Then match each response == imageSchema