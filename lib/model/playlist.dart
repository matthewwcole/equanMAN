class Playlist {
  final String title;
  final List<String> audioAssets;

  Playlist({required this.title, required this.audioAssets});

  static final List<Playlist> allPlaylists = [
    Playlist(
      title: 'Resonant Breath 6-0-9-0',
      audioAssets: ['assets/audio/i6.wav', 'assets/audio/e9.wav'],
    ),
    Playlist(
      title: 'Resonant Breath 6-2-9-2',
      audioAssets: [
        'assets/audio/i6.wav',
        'assets/audio/hold2.wav',
        'assets/audio/e9.wav',
        'assets/audio/hold2.wav',
      ],
    ),
    Playlist(
      title: 'Resonant Breath 6-5-9-5',
      audioAssets: [
        'assets/audio/i6.wav',
        'assets/audio/hold5.wav',
        'assets/audio/e9.wav',
        'assets/audio/hold5.wav',
      ],
    ),
    Playlist(
      title: 'Resonant Breath 6-8-9-8',
      audioAssets: [
        'assets/audio/i6.wav',
        'assets/audio/hold8.wav',
        'assets/audio/e9.wav',
        'assets/audio/hold8.wav',
      ],
    ),
    // You can add more playlists here
  ];
}
