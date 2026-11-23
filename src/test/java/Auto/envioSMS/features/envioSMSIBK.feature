Feature: Envio de SMS de IBK desde Karate

  Background:
    * def auth = callonce read('classpath:Auto/envioSMS/features/TokenSMS.feature')
    * def accessToken = auth.response.access_token
    * def reponsesJson = read ('classpath:Auto/responses/smsResponse.json')
    * def requestSms = read ('classpath:Auto/request/sendSMS.json')

  @tagEnvioSMS @componenteSMS
  Scenario: Envio de SMS a cualquier Numero
    Given url urlSMSEnvio
    And header Authorization = 'Bearer ' + accessToken
    And request requestSms.smsOk
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