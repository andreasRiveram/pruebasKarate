@componenteSMS2
Feature: Simulación de Autenticación Dinámica y Flujo de APIs en Pipeline

  Background:
    * url urlRestFull
    * print 'Iniciando simulación en ambiente:', env
    * print 'admin', mi_variableMVN_clientId
    * print 'pass', mi_variableMVN_clientSecret

  Scenario: Obtener Token dinámico y crear un registro para el Pipeline

  # PASO 1: Generar el token de autenticación (Auth)
    Given path '/auth'
    And request { "username": "#(mi_variableMVN_clientId)" , "password": "#(mi_variableMVN_clientSecret)" }
    When method post
    Then status 200
    And match response.token == '#notnull'

    * def dinamicToken = response.token
    * print 'Token obtenido con éxito:', dinamicToken

  # PASO 2: Crear un registro inyectando seguridad (Simulación de negocio)
    Given path '/booking'
  # Algunas APIs piden el token en las Cookies, otras en el Header. Aquí simulamos el envío protegido.
  #  And header Cookie = 'token=' + dinamicToken
    # Declaramos el payload usando fechas estables de simulación que la API acepta siempre
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request
        """
        {
            "firstname": "Gino",
            "lastname": "Rivera",
            "totalprice": 150,
            "depositpaid": true,
            "bookingdates": {
                "checkin": "2018-01-01",
                "checkout": "2019-01-01"
            },
            "additionalneeds": "Automation Testing"
        }
        """

    When method post
    Then status 200

  # Validaciones asertivas del contrato
    And match response.bookingid == '#number'
    And match response.booking.firstname == 'Gino'
    * print 'Simulación completada con éxito. ID de Reserva:', response.bookingid