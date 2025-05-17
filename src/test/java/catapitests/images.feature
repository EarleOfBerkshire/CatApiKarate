Feature: Image endpoint tests

  Background:
    * url baseURL
    * configure headers = ({ 'X-API-Key' : apiKey })

  Scenario Outline: You can filter image results by breed or category ids
    Given path 'images/search'
    And param <filter> = <filterValue>
    When method get
    Then status 200
    And match  response[0].<responseName>[0].id == <filterValue>

    Examples:
      | filter       | filterValue | responseName |
      | category_ids | 1           | categories   |
      | breed_ids    | 'beng'      | breeds       |


  Scenario: You can retrieve more that 1 image using the limit parameter
    Given path 'images/search'
    And param limit = 15
    And param has_breeds = 1
    When method get
    Then status 200
    And assert response.length == 15
    And match each response == imageSchema


  Scenario: You can retrieve all of the images you have uploaded
    Given path 'images/'
    And param limit = 100
    When method get
    Then status 200
    And match  each response[*].original_filename == "mycat.jpg"


  Scenario: You can retrieve an individual Image by using it's unique ID
    Given path 'images/',testImageId
    When method get
    Then status 200
    And match response.id == testImageId
    And match response == imageSchema


  Scenario: You can upload images via ./images/upload and then retrieve the image details
    Given path 'images/upload'
    And header Content-Type = 'multipart/form-data'
    And multipart file file =  { read:'./mycat.jpg',  filename: 'mycat.jpg', contentType: 'image/jpeg' }
    When method post
    Then status 201
    * def newImageId = response.id
    And match response.original_filename == 'mycat.jpg'
    Given path 'images/',newImageId
    And method get
    Then status 200
    And match response.id == newImageId
    Then match response == imageSchema


  Scenario: You delete one of your images and it is no longer available retrieve all of the images you have uploaded
    Given path 'images/'
    When method get
    Then status 200
    * def deleteImageId = response[0].id
    Given path 'images/',deleteImageId
    When method delete
    Then status 204
    Given path 'images/',deleteImageId
    And method get
    Then status 400
    And match response contains "Couldn't find an image matching the passed 'id' of ",deleteImageId