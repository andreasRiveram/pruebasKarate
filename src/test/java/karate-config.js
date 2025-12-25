function fn() {
  // 1. Primero determinamos el entorno (env)
  var env = karate.env;
  if (!env) {
    env = 'dev';
  }
  karate.log('karate.env system property was:', env);

  // 2. Obtenemos las credenciales de Maven
  var mi_variableMVN_clientId = karate.properties['client-Id'];
  var mi_variableMVN_clientSecret = karate.properties['client-Secret'];
  var mi_variableMVN_refreshToken = karate.properties['refresh-Token'];

  // 3. Definimos el objeto config inicial (ya con el env correcto)
  var config = {
      env: env,
      baseUrl: '',
      accessToken: '',
      mi_variableMVN_clientId: mi_variableMVN_clientId,
      mi_variableMVN_clientSecret: mi_variableMVN_clientSecret,
      mi_variableMVN_refreshToken: mi_variableMVN_refreshToken
  };

  // 4. Lógica por ambiente
  if (env == 'dev') {
    var baseUrlToken = 'https://api-campaign-us-2.goacoustic.com/oauth/token';

    var formFields = {
      baseUrl: baseUrlToken,
      grant_type: 'refresh_token',
      client_id_valor_feature: mi_variableMVN_clientId,
      client_secret_valor_feature: mi_variableMVN_clientSecret,
      refresh_token_valor_feature: mi_variableMVN_refreshToken
    };

    // 5. Llamada al feature y asignación al objeto config
    var result = karate.callSingle('classpath:envioSMS/TokenSMS.feature', formFields);

    config.accessToken = result.response.access_token;
    config.baseUrl = baseUrlToken;

  } else if (env == 'e2e') {
    // config.baseUrl = 'otra_url';
  }

  return config;
}