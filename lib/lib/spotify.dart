import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late SpotifyClient spotify;

Future setupSpotify() async {
  spotify = await SpotifyClient.initialize();
}

class SpotifyClient {
  late final String? token;
  static Dio dio = Dio();

  static Future<SpotifyClient> initialize() async {
    Response response =
        await Dio().post("https://accounts.spotify.com/api/token",
            data: {
              "grant_type": "client_credentials",
              "client_id": dotenv.env["SPOTIFY_CLIENT_ID"],
              "client_secret": dotenv.env["SPOTIFY_CLIENT_SECRET"],
            },
            options: Options(
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
              },
            ));
    final data = response.data;
    final token = data["access_token"];
    SpotifyClient spotify = SpotifyClient();
    spotify.token = token;
    return spotify;
  }

  void test() {
    print(token);
  }
}
