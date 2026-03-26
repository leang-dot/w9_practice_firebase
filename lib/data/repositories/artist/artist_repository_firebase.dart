import 'package:http/http.dart' as http;
import 'package:w9_practice_firebase/data/dtos/artist_dto.dart';
import 'dart:convert';

import 'package:w9_practice_firebase/data/repositories/artist/artist_repository.dart';
import 'package:w9_practice_firebase/model/artist/artist.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistUri = Uri.https(
    'w9-practice-cfaaa-default-rtdb.firebaseio.com',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtist() async {
    final http.Response response = await http.get(artistUri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> artist =
          json.decode(response.body) as Map<String, dynamic>;
      return artist.entries.map((element) {
        String id = element.key;
        return ArtistDto.fromJson({...element.value} , id);
      }).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
