import 'package:equanimity/model/playlist.dart';
import 'package:equanimity/model/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class PlaylistDropdown extends StatefulWidget {
  final ValueChanged<Playlist> onChanged;

  const PlaylistDropdown({super.key, required this.onChanged});

  @override
  State<PlaylistDropdown> createState() => _PlaylistDropdownState();
}

class _PlaylistDropdownState extends State<PlaylistDropdown> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      dropdownColor: const Color(0xFF023e8a),
      style: const TextStyle(color: Pallete.primaryText, fontSize: 16),
      value: _selectedIndex,
      items: Playlist.allPlaylists
          .asMap()
          .entries
          .map((e) => DropdownMenuItem<int>(
                value: e.key,
                child: Text(e.value.title),
              ))
          .toList(),
      onChanged: (index) {
        if (index != null) {
          setState(() => _selectedIndex = index);
          widget.onChanged(Playlist.allPlaylists[index]);
        }
      },
    );
  }
}