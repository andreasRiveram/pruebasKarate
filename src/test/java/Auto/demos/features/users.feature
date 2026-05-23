Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * def responseUsersById = read ('classpath:Auto/responses/usersResponse.json')
    * configure afterScenario =
    """
    function() {
      karate.log('Scenario completo Ok:', karate.scenario.name);
      if (karate.info.errorMessage) {
        karate.log('FAILED:', karate.info.errorMessage);
      }
    }
    """
    # Usamos la variable del config en lugar de hardcodear la URL
    * url placeholderUrl

  @tag1
  Scenario Outline: get all users and then get the first user by id - GRM
    Given path '/users'
    When method get
    Then status 200

   # * def first = response[valorID]
   # * print '/', first

    Given path 'users', valorID
    When method get
    Then status 200
   # And match response == responseUsersById
    # Ejecutamos el match y guardamos el resultado en una variable
    * def resultadoMatch = karate.match(response, responseUsersById.responseOK)

  # Imprimimos el resultado en el reporte
    * print '¿Es la respuesta correcta?:', resultadoMatch.pass

  # Si quieres que aparezca un mensaje personalizado
    * def mensaje = resultadoMatch.pass ? 'VALIDACIÓN EXITOSA' : 'ERROR EN ESTRUCTURA'
    * print 'Resultado final:', mensaje
   Examples:
     | read('classpath:Auto/data/dataUsers.csv') |


  @tag2
  Scenario: create a user and then get it by ids
    * def user =
      """
      {
        "name": "Test User",
        "username": "testuser",
        "email": "test@user.com",
        "address": {
          "street": "Has No Name",
          "suite": "Apt. 123",
          "city": "Electri",
          "zipcode": "54321-6789"
        }
      }
      """

    Given url 'https://jsonplaceholder.typicode.com/users'
    And request user
    When method post
    Then status 201

    * def id = response.id
    * print 'created id is: ', id

    Given path id
    # When method get
    # Then status 200
    # And match response contains user
  #mvn clean verify -Dkarate.options="--tags @tag2" && open target/karate-reports/karate-summary.html
  