import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
}

class SongFirebaseServiceImplementation implements SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    List<SongEntity> songs = [];

    try {
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releasedDate')
          .limit(3)
          .get();

      data.docs.forEach((element) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      });

      return Right(songs);
    } catch (err) {
      return Left("Error occured: $err");
    }
  }
}
