import 'package:equanimity/model/playlist.dart';
import 'package:equanimity/model/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class PlaylistDropdown extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const PlaylistDropdown({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      dropdownColor: const Color(0xFF023e8a),
      style: const TextStyle(
        color: Pallete.primaryText,
        fontSize: 16,
      ),
      value: selectedIndex,                  // ✅ use the passed-in prop
      items: Playlist.allPlaylists
          .asMap()
          .entries
          .map(
            (e) => DropdownMenuItem<int>(
              value: e.key,
              child: Text(e.value.title),
            ),
          )
          .toList(),
      onChanged: (index) {
        if (index != null) {
          onChanged(index);                  // ✅ delegate to parent
        }
      },
    );
  }
}