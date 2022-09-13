enum GenreType {
  bass,
  chill,
  drumBass,
  drumStep,
  dubstep,
  eDM,
  electronic,
  futureHouse,
  hardStyle,
  house,
  indie,
  melodicDubstep,
  trap,
  glitchHop,
  phonk,
  futureBass,
  bassHouse,
}

enum Mood {
  angry,
  dark,
  dreamy,
  epic,
  euphoric,
  energetic,
  fear,
  funny,
  glamorous,
  gloomy,
  happy,
  hopeful,
  laidBack,
  mysterious,
  peaceful,
  quirky,
  relaxing,
  restless,
  romantic,
  sad,
  scary,
  sexy,
  suspense,
  weird,
}

enum Version { regular, instrumental }

extension GenreExt on GenreType {
  static const genres = {
    GenreType.bass: 1,
    GenreType.chill: 2,
    GenreType.drumBass: 3,
    GenreType.drumStep: 4,
    GenreType.dubstep: 5,
    GenreType.eDM: 6,
    GenreType.electronic: 7,
    GenreType.futureHouse: 8,
    GenreType.hardStyle: 9,
    GenreType.house: 10,
    GenreType.indie: 11,
    GenreType.melodicDubstep: 12,
    GenreType.trap: 14,
    GenreType.glitchHop: 15,
    GenreType.phonk: 16,
    GenreType.futureBass: 17,
    GenreType.bassHouse: 18,
  };

  int get select => genres[this]!;
}

extension MoodsExt on Mood {
  static const moods = {
    Mood.angry: 1,
    Mood.dark: 2,
    Mood.dreamy: 3,
    Mood.epic: 4,
    Mood.euphoric: 5,
    Mood.energetic: 6,
    Mood.fear: 7,
    Mood.funny: 8,
    Mood.glamorous: 9,
    Mood.gloomy: 10,
    Mood.happy: 11,
    Mood.hopeful: 12,
    Mood.laidBack: 13,
    Mood.mysterious: 14,
    Mood.peaceful: 15,
    Mood.quirky: 16,
    Mood.relaxing: 17,
    Mood.restless: 18,
    Mood.romantic: 19,
    Mood.sad: 20,
    Mood.scary: 21,
    Mood.sexy: 22,
    Mood.suspense: 23,
    Mood.weird: 24,
  };

  int get select => moods[this]!;
}

extension VersionExt on Version {
  static const version = {
    Version.regular: 'regular',
    Version.instrumental: 'instrumental',
  };

  String get select => version[this]!;
}

extension Name on int {
 String genre() {
    switch (this) {
      case 1:
        return 'Bass';
      case 2:
        return 'Chill';
      case 3:
        return 'Drum Bass';
      case 4:
        return 'Drum Step';
      case 5:
        return 'Dubstep';
      case 6:
        return 'EDM';
      case 7:
        return 'Electronic';
      case 8:
        return 'Future House';
      case 9:
        return 'Hard Style';
      case 10:
        return 'House';
      case 11:
        return 'Indie';
      case 12:
        return 'Melodic Dubstep';
      case 13:
        return 'Trap';
      case 14:
        return 'Glitch Hop';
      case 15:
        return 'Phonk';
      case 16:
        return 'Future Bass';
      case 17:
        return 'Bass House';
      default:
        return '';
    }
  }

 String mood() {
    switch (this) {
      case 1:
        return 'Angry';
      case 2:
        return 'Dark';
      case 3:
        return 'Dreamy';
      case 4:
        return 'Epic';
      case 5:
        return 'Euphoric';
      case 6:
        return 'Energetic';
      case 7:
        return 'Fear';
      case 8:
        return 'Funny';
      case 9:
        return 'Glamorous';
      case 10:
        return 'Gloomy';
      case 11:
        return 'Happy';
      case 12:
        return 'Hopeful';
      case 13:
        return 'LaidBack';
      case 14:
        return 'Mysterious';
      case 15:
        return 'Peaceful';
      case 16:
        return 'Quirky';
      case 17:
        return 'Relaxing';
      case 18:
        return 'Restless';
      case 19:
        return 'Romantic';
      case 20:
        return 'Sad';
      case 21:
        return 'Scary';
      case 22:
        return 'Sexy';
      case 23:
        return 'Suspense';
      case 24:
        return 'Weird';
      default:
        return '';
    }
  }
}
