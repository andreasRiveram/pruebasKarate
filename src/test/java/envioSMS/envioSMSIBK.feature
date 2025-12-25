Feature: Envio de SMS de IBK desde Karate

  @tag1
  Scenario: Envio de SMS a cualquier Numero
    Given url 'https://api-campaign-us-2.goacoustic.com/rest/channels/sms/externalconsentsends'
    And header Authorization = 'Bearer ' + accessToken
    And request
      """
            {
          "content": "Hola %%primerNombre%%, Mensaje Prueba de prueba SMS Correcto",
          "contacts": [
              {
                  "phoneNumber": "51929552346",
                  "personalization": {
                      "primerNombre": "Gino QE"
                  }
              }
          ],
          "channelQualifier": "974d75fb-2789-408e-89c2-b0141276a79a",
          "source": ""
      }
      """
    When method post
    Then status 202
