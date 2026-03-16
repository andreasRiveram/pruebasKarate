Feature: Named setup scenarios

@setup=users
Scenario: Setup user data
  * def users =
    """
    [
      { id: 1, name: 'Admin' },
      { id: 2, name: 'User' }
    ]
    """

@setup=posts
Scenario: Setup post data
  * def posts =
    """
    [
      { id: 101, title: 'First' },
      { id: 102, title: 'Second' }
    ]
    """

@componenteDinamico
Scenario Outline: Test user: <name>
  Given url 'https://jsonplaceholder.typicode.com'
  And path 'users', <id>
  When method get
  Then status 200

  Examples:
  | karate.setup('users').users |