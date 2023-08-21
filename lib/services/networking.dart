import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getWeatherData() async {
    http.Response response = await http.get(Uri.parse(this.url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }
}
