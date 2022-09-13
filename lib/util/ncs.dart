import 'package:chaleno/chaleno.dart';
import 'package:ncs_io/src/models/artist.dart';
import 'package:ncs_io/src/models/song.dart';
import 'package:ncs_io/util/just_parser.dart';

class NCS {
  static Future<List<Song>>? getMusic({int page = 1}) async {
    String url = "https://ncs.io/music?page=$page";
    var document = await Chaleno().load(url);
    var songsElement = document?.querySelectorAll('div.col-lg-2.item');
    List<Song> songs = JustParser.parseDashboard(dashboard: songsElement);
    return songs;
  }

  static Future<List<Song>>? searchMusic(
      {int page = 1,
      int? genreType,
      int? mood,
      String? search,
      List<String>? version}) async {
    String url =
        "https://ncs.io/music-search?page=$page${(genreType != null) ? '&genre=$genreType' : ''}${(mood != null) ? '&mood=$mood' : ''}${(version != null) ? '&version=${version.join('-')}' : ''}${(search != null) ? '&q=$search' : ''}";
    var document = await Chaleno().load(url);
    Result? table = document?.querySelector('.tablesorter');
    List<Song> songs = JustParser.parseTable(table: table);
    return songs;
  }

  static Future<Artist> getArtistInfo({required dynamic artist}) async {
    String? artistUrl = (artist is! String) ? (artist as Artist).url : artist;
    String url = 'https://ncs.io$artistUrl';
    var document = await Chaleno().load(url);

    Result? infoElement = document?.querySelector('.details .info');
    String? name = infoElement?.querySelector('h5')?.innerHTML;
    List<String>? genres =
        infoElement?.querySelector('.tags')?.innerHTML?.split(', ');
    String? image = document
        ?.querySelector('div.img')
        .attr('style')
        ?.trim()
        .replaceAll("url('", '')
        .replaceAll("')", '')
        .replaceAll('background-image: ', '');
    // Result? songsElement = document?.querySelector('.table tbody');
    // List<Song> songs = JustParser.parseTable(table: songsElement);
    return Artist(
      name: name,
      url: artistUrl,
      genres: genres,
      img: image,
      // songs: songs,
    );
  }
}
