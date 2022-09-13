import 'package:chaleno/chaleno.dart';
import 'package:ncs_io/src/models/song.dart';
import 'package:html/parser.dart' as parser;
import 'package:ncs_io/src/models/tag.dart';
import '../src/models/artist.dart';

class JustParser {
  static List<Song> parseDashboard({List<Result>? dashboard}) {
    List<Song> songs = List.generate(dashboard?.length ?? 0, (index) {
      Result? imageLinkElement = dashboard?[index].querySelector('a[href]');
      String? url = imageLinkElement?.href;
      Result? infoElement = dashboard?[index].querySelector('.col-6');
      String? genre = infoElement?.querySelector('span strong')?.text;
      Result? player = dashboard?[index].querySelector('.btn');
      String? cover = player
          ?.attr('data-cover')
          ?.replaceAll(RegExp('/100x100/'), '/325x325/');
      String? name = player?.attr('data-track');
      String? songUrl = player?.attr('data-url');
      String? artistsElement = player?.attr('data-artist');
      List<String>? artistStringList = artistsElement?.split(', ');
      List<Artist> artists =
          List.generate(artistStringList?.length ?? 0, (index) {
        Result? artElement =
            Result(parser.parse(artistStringList?[index]).querySelector('a'));
        String? url = artElement.attr('href');
        String? name = artElement.innerHTML;
        return Artist(url: url, name: name);
      });

      return Song(
          imageUrl: cover,
          songUrl: songUrl,
          url: url,
          genre: genre,
          name: name,
          artists: artists);
    });

    return songs;
  }

  static List<Song> parseTable({Result? table}) {
    List<Result> trs = table?.querySelectorAll('tbody > tr') ?? [];
    List<Result> tds = table?.querySelectorAll('tbody > tr > td') ?? [];
    final songsCount = tds.length ~/ 8;

    List<Song> songs = List.generate(songsCount, (i) {
      Result? player = trs[i].querySelector('.player-play');
      String? name = player?.attr('data-track');
      String? songUrl = player?.attr('data-url');
      String? genre = trs[i].querySelector('.genre')?.attr('title');
      String? cover =
          player?.attr('data-cover')?.replaceAll('/100x100/', '/325x325/');
      String? artistsElement = player?.attr('data-artist');
      List<String>? artistStringList = artistsElement?.split(', ');
      List<Artist> artists =
          List.generate(artistStringList?.length ?? 0, (index) {
        Result? artElement =
            Result(parser.parse(artistStringList?[index]).querySelector('a'));
        String? url = artElement.attr('href');
        String? name = artElement.innerHTML;
        return Artist(url: url, name: name);
      });

      List<Result>? tagsElement = trs[i].querySelectorAll('.tag');
      List<Tag> tags = List.generate(tagsElement?.length ?? 0, (index) {
        String? name = tagsElement?[index].text;
        String? url = tagsElement?[index].href;
        RegExpMatch? moodR =
            RegExp(r'mood=[0-9]{2}').firstMatch(url?.split('?')[1] ?? '');
        String? mood = moodR?.group(0)?.replaceAll('mood=', '');
        RegExpMatch? genreR =
            RegExp(r'genre=[0-9]{2}').firstMatch(url?.split('?')[1] ?? '');
        String? genre = genreR?.group(0)?.replaceAll('genre=', '');
        return Tag(
            name: name,
            mood: int.tryParse(mood ?? ''),
            genre: int.tryParse(genre ?? ''));
      });

      return Song(
          name: name,
          songUrl: songUrl,
          genre: genre,
          imageUrl: cover,
          artists: artists,
          tags: tags);
    });
    return songs;
  }
}
