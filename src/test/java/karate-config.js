function fn() {
  karate.configure('ssl', true); // O 'ssl', { trustAll: true } según tu versión

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
      urlTokenSMS: 'https://api-campaign-us-2.goacoustic.com/oauth/token',
      urlSMSEnvio: 'https://api-campaign-us-2.goacoustic.com/rest/channels/sms/externalconsentsends',
      urlRestFull: 'https://restful-booker.herokuapp.com',
      placeholderUrl: 'https://jsonplaceholder.typicode.com',
      baseUrlSMS: '',
      accessToken: '',
      mi_variableMVN_clientId: mi_variableMVN_clientId,
      mi_variableMVN_clientSecret: mi_variableMVN_clientSecret,
      mi_variableMVN_refreshToken: mi_variableMVN_refreshToken
  };

  // 4. Lógica por ambiente
  if (env == 'dev') {
        config.baseUrlSMS = config.urlTokenSMS

    }


  return config;
}