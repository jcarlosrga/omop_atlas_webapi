define([], function () {
	var configLocal = {};

	// WebAPI
	configLocal.api = {
		name: 'OHDSI',
		//url: '${WEBAPI_URL}'
		url: 'http://192.168.1.8:8080/WebAPI/'
	};

	configLocal.cohortComparisonResultsEnabled = false;
	configLocal.userAuthenticationEnabled = false;
	configLocal.plpResultsEnabled = false;

	return configLocal;
});
