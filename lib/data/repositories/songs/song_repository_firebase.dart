import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https(
    'w9-practice-cfaaa-default-rtdb.firebaseio.com',
    '/songs.json',
  );




  @override
  Future<List<Song>> fetchSongs() async {
    final http.Response response = await http.get(songsUri);

    if(response.statusCode == 200){
      Map<String, dynamic> songsMap = json.decode(response.body);

      return songsMap.entries.map((song){
        String id = song.key;
        return SongDto.fromJson(id ,{
          ...song.value,
        });
      }).toList();
    }else{
      throw Exception("Failed to load Songs");
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {
    final songs = await fetchSongs();
    try {
      return songs.firstWhere((song) => song.id == id);
    } catch (e) {
      return null;
    }
  }
