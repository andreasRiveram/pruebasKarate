Feature: Capturar Token

  @tokenSMS
  Scenario: Obtener Token SMS
    Given url baseUrlSMS
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field grant_type = 'refresh_token'
    And form field client_id = mi_variableMVN_clientId
    And form field client_secret = mi_variableMVN_clientSecret
    And form field refresh_token = mi_variableMVN_refreshToken
    When method post
    Then status 200

