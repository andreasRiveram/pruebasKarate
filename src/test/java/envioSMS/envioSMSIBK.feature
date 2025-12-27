Feature: Envio de SMS de IBK desde Karate

  Background:
    * def reponsesJson = read ('classpath:envioSMS/responses/smsResponse.json')

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
   # And match response == reponsesJson.statusCode202
    # Ejecutamos el match y guardamos el resultado en una variable
    * def resultadoMatch = karate.match(response, reponsesJson.statusCode202)

  # Imprimimos el resultado en el reporte
    * print '¿Es la respuesta correcta?:', resultadoMatch.pass

  # Si quieres que aparezca un mensaje personalizado
    * def mensaje = resultadoMatch.pass ? 'VALIDACIÓN EXITOSA' : 'ERROR EN ESTRUCTURA'
    * print 'Resultado final:', mensaje