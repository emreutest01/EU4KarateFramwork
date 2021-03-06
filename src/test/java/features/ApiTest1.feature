Feature: exchange rate api tests

  Scenario: basic test with status code validation
    Given url 'https://api.exchangeratesapi.io/latest'
    When method GET
    Then status 200

  Scenario: get rates for specific day
    Given url 'https://api.exchangeratesapi.io/2010-06-11'
    When  method GET
    Then status 200
    
  Scenario: headers verification
    Given url 'https://api.exchangeratesapi.io/2010-06-11'
    When method GET
    Then status 200
    And  match header Content-Type == 'application/json'
    And match header Vary == 'Accept-Encoding'
    And match header Date == '#present'

  Scenario:  json body verification
    Given url 'https://api.exchangeratesapi.io/latest'
    When method GET
    Then status 200
    And match header Content-Type == 'application/json'
    And print response.base

    And match response.base == 'EUR'
    And print response.rates.USD
    And match response.rates.TRY == '#present'
    And match response.rates.USD == 1.1912







