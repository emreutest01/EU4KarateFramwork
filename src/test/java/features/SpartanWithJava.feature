Feature: Karate Java Integration
  Background:
    * def spartanUrl = 'http://18.208.178.105:8000'
  Scenario: get a spartan with request header
    Given  url spartanUrl
    And path "api/spartans"
    And header Accept = 'application/json'
    When method GET
    Then status 200



  Scenario: Create a new spartan
    Given  url spartanUrl
    And path "api/spartans"
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
    """
    {
    "gender" : "Female",
    "name" : "Adam",
    "phone" : 2144564346
    }
    """

    When method POST
    Then status 201
    And print response



  Scenario: reading java methods
    * def SDG = Java.type('utilities.SpartanDataGenerator')
    * def newSpartan = SDG.createSpartan()
    * print newSpartan


  Scenario: Create a spartan with Random Data(Java) and delete
    * def SDG = Java.type('utilities.SpartanDataGenerator')
    * def newSpartan = SDG.createSpartan()
    Given  url spartanUrl
    And path "api/spartans"
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request newSpartan
    When method POST
    Then status 201
    And print response
    And match response.success == 'A Spartan is Born!'
    #verify name
    And match response.data.name == newSpartan.name
    And def idToDelete = response.data.id
    Given url spartanUrl
    And path 'api/spartans'
    And path idToDelete
    When method DELETE
    Then status 204

