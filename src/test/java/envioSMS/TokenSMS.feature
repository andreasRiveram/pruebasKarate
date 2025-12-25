Feature: Capturar Token

  @tokenSMS
  Scenario: Obtener Token SMS
    Given url baseUrl
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field grant_type = 'refresh_token'
    And form field client_id = client_id_valor_feature
    And form field client_secret = client_secret_valor_feature
    And form field refresh_token = refresh_token_valor_feature
    When method post
    Then status 200

