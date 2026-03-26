import 'package:flutter/material.dart';
import 'package:w9_practice_firebase/data/repositories/artist/artist_repository.dart';
import 'package:w9_practice_firebase/model/artist/artist.dart';
import 'package:w9_practice_firebase/ui/utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  ArtistRepository artistRepository;
  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository}) {
    _init();
  }

  void _init() async {
    artistsValue = AsyncValue.loading();
    notifyListeners();
    try {
        List<Artist> artists = await artistRepository.fetchArtist();
        artistsValue = AsyncValue.success(artists);
        notifyListeners();
    } catch (error) {
      artistsValue = AsyncValue.error(error);
    }
    notifyListeners();
  }
}
