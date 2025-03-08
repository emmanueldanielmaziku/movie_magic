// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nowplaying.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NowPlayingAdapter extends TypeAdapter<NowPlaying> {
  @override
  final int typeId = 1;

  @override
  NowPlaying read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NowPlaying(
      id: fields[0] as int,
      title: fields[1] as String,
      overview: fields[2] as String,
      posterPath: fields[3] as String,
      backdropPath: fields[4] as String,
      voteAverage: fields[5] as double,
      genreIds: (fields[6] as List).cast<int>(),
      releaseDate: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NowPlaying obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.backdropPath)
      ..writeByte(5)
      ..write(obj.voteAverage)
      ..writeByte(6)
      ..write(obj.genreIds)
      ..writeByte(7)
      ..write(obj.releaseDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NowPlayingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
