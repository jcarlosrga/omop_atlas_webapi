define([], function () {
  var configLocal = {};

  configLocal.api = {
      name: '${ORGNAME}',
      url: 'https:/192.168.1.8/WebAPI/'
  };

  return configLocal;
});
