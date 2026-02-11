// lib/viewmodel/player_viewmodel.dart
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:equanimity/model/player_state.dart';
import 'package:equanimity/model/position_data.dart';
import '../services/audio_player_service.dart';

// This ViewModel is simple, mainly passing through the service's functionality.
// It could be expanded to include more complex logic, like managing playlists.
class PlayerViewModel {
  final AudioPlayerService _audioPlayerService;

  PlayerViewModel(this._audioPlayerService);

  // Pass streams directly from the service to the view
  Stream<PlayerState> get playerStateStream => _audioPlayerService.playerStateStream;
  Stream<PositionData> get positionDataStream => _audioPlayerService.positionDataStream;
  Stream<just_audio.SequenceState?> get sequenceStateStream => _audioPlayerService.sequenceStateStream;
  just_audio.PlayerState? get currentJustAudioPlayerState => _audioPlayerService.player.playerState;

  // Getters
  bool get hasNext => _audioPlayerService.hasNext;
  bool get hasPrevious => _audioPlayerService.hasPrevious;

  // Pass actions to the service
  void play() => _audioPlayerService.play();
  void pause() => _audioPlayerService.pause();
  void seek(Duration position) => _audioPlayerService.seek(position);
  void seekToNext() => _audioPlayerService.seekToNext();
  void seekToPrevious() => _audioPlayerService.seekToPrevious();


  // The ViewModel is a good place to handle disposal
  void dispose() => _audioPlayerService.dispose();
}
