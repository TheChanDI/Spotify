import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/song.dart';

class SongModel {
  final String? artist;
  final String? title;
  final num? duration;
  final Timestamp? releasedDate;

  SongModel({
    required this.artist,
    required this.title,
    required this.duration,
    required this.releasedDate,
  });

  SongModel.fromJson(Map<String, dynamic> json)
      : artist = json['artist'],
        title = json['title'],
        duration = json['duration'],
        releasedDate = json['releasedDate'];
}

extension SongModelX on SongModel {
  SongEntity toEntity() => SongEntity(
        artist: artist ?? '',
        title: title ?? '',
        duration: duration ?? 0,
        releasedDate: releasedDate ?? Timestamp(0, 0),
      );
}
