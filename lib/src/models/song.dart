import 'package:ncs_io/src/models/tag.dart';

import 'artist.dart';

class Song {
  final String? name;
  final String? genre;
  final List<Artist>? artists;
  final String? url;
  final String? imageUrl;
  final String? songUrl;
  final List<Tag>? tags;

  Song({
    this.name,
    this.genre,
    this.artists,
    this.url,
    this.imageUrl,
    this.songUrl,
    this.tags,
  });
}
