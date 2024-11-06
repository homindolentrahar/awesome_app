enum ApiMethod {
  get('GET'),
  post('POST'),
  patch('PATCH'),
  put('PUT'),
  delete('DELETE');

  final String value;

  const ApiMethod(this.value);
}

enum ApiType {
  request("REQUEST"),
  response("RESPONSE");

  final String value;

  const ApiType(this.value);
}
