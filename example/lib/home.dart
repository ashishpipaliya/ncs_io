import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncs_io/ncs_io.dart';
import 'package:ncs_io_example/player_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Song>>(
          future: NCS.searchMusic(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  Song? song = snapshot.data?[index];

                  return ListTile(
                      onTap: () {
                        Navigator.of(context).push(DialogRoute(
                            context: context,
                            builder: (context) => Material(
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    margin: const EdgeInsets.all(15),
                                    color: Colors.white,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                              child: Image.network(
                                                  song?.imageUrl ?? '')),
                                          Text(song?.name ?? 'Name Error'),
                                          Text(song?.url ?? 'URL Error'),
                                          Text(song?.songUrl ??
                                              'Song Url Error'),
                                          Text(song?.genre ?? 'Genre Error'),
                                          const Text('Artists'),
                                          Wrap(
                                            children: List.generate(
                                                song?.artists?.length ?? 0,
                                                (index) => InputChip(
                                                      onPressed: () async {
                                                        Artist artist = await NCS
                                                            .getArtistInfo(
                                                                artist:
                                                                    song?.artists?[
                                                                        index]);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Material(
                                                            child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Image.network(
                                                                      artist.img ??
                                                                          ''),
                                                                  Text(artist
                                                                          .name ??
                                                                      ''),
                                                                  const Divider(
                                                                      thickness:
                                                                          2),
                                                                  Text(artist
                                                                          .url ??
                                                                      ''),
                                                                  const Divider(
                                                                      thickness:
                                                                          2),
                                                                  ...List.generate(
                                                                      artist.genres
                                                                              ?.length ??
                                                                          0,
                                                                      (index) =>
                                                                          ListTile(
                                                                              title: Text(artist.genres?[index] ?? ''))),
                                                                ]),
                                                          ),
                                                        );
                                                      },
                                                      label: Text(
                                                          '${song?.artists?[index].name} - ${song?.artists?[index].url}'),
                                                    )),
                                          ),
                                          if (song?.tags != null)
                                            const Text('Tags'),
                                          Wrap(
                                            children: List.generate(
                                                song?.tags?.length ?? 0,
                                                (index) => Chip(
                                                      label: Text(
                                                          '${song?.tags?[index].name}'),
                                                    )),
                                          ),
                                          Wrap(
                                            children: List.generate(
                                                song?.tags?.length ?? 0,
                                                (index) => song?.tags?[index]
                                                            .genre !=
                                                        null
                                                    ? Chip(
                                                        label: Text(song
                                                                ?.tags?[index]
                                                                .genre
                                                                ?.genre() ??
                                                            ''),
                                                      )
                                                    : const SizedBox.shrink()),
                                          ),
                                          Wrap(
                                            children: List.generate(
                                                song?.tags?.length ?? 0,
                                                (index) => song?.tags?[index]
                                                            .mood !=
                                                        null
                                                    ? Chip(
                                                        label: Text(song
                                                                ?.tags?[index]
                                                                .mood
                                                                ?.mood() ??
                                                            ''),
                                                      )
                                                    : const SizedBox.shrink()),
                                          )
                                        ]),
                                  ),
                                )));
                      },
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(song?.imageUrl ?? '')),
                      title: Text(song?.name ?? ''));
                },
              );
            }
            return const Center(child: CupertinoActivityIndicator());
          }),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchPage()));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<Song>?>(
        future: NCS.getMusic(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200),
              shrinkWrap: true,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Song? song = snapshot.data?[index];
                return Container(
                  width: 150,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          song?.imageUrl ?? '',
                        ),
                        onError: (exception, stackTrace) => const Center(
                          child: FlutterLogo(style: FlutterLogoStyle.markOnly),
                        ),
                      )),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Song> songs = [];

  bool isSearching = false;
  bool isDataFetched = false;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
            title: TextField(
          controller: searchController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search sound',
              filled: true,
              suffixIcon: InkWell(
                  onTap: () async {
                    setState(() {
                      isSearching = false;
                      isDataFetched = false;
                    });
                    songs.clear();
                    setState(() => isSearching = true);
                    songs.addAll(await NCS.searchMusic(
                            search: searchController.text.trim()) ??
                        []);
                    setState(() {
                      isDataFetched = true;
                      isSearching = false;
                    });
                  },
                  child: const Icon(Icons.search))),
        )),
        body: Stack(
          children: [
            Visibility(
                visible: !isDataFetched & !isSearching,
                child: const Center(
                  child: Text('Search results appear here'),
                )),
            Visibility(
                visible: !isDataFetched & isSearching,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CupertinoActivityIndicator(color: Colors.deepPurple),
                      Text('Searching...'),
                    ],
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemCount: songs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Song song = songs[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlayerScreen(song: song)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade200),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(song.imageUrl ?? '',
                                    width: 60, height: 60)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(song.name ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Wrap(
                                    children: [
                                      Icon(Icons.person,
                                          color: Colors.deepPurple.shade400),
                                      ...List.generate(
                                          song.artists?.length ?? 0,
                                          (index) => Container(
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .deepPurple.shade50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                padding:
                                                    const EdgeInsets.all(3),
                                                margin: const EdgeInsets.only(
                                                    right: 3),
                                                child: Text(
                                                    song.artists?[index].name ??
                                                        ''),
                                              ))
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Icon(Icons.tag,
                                          color: Colors.green.shade400),
                                      ...List.generate(
                                          song.tags?.length ?? 0,
                                          (index) => Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.green.shade50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                padding:
                                                    const EdgeInsets.all(3),
                                                margin: const EdgeInsets.only(
                                                    right: 3),
                                                child: Text(
                                                    song.tags?[index].name ??
                                                        ''),
                                              ))
                                    ],
                                  ),
                                  Text(song.genre ?? '',
                                      style:
                                          const TextStyle(color: Colors.grey))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 10, color: Colors.transparent),
                )),
          ],
        ),
      ),
    );
  }
}
