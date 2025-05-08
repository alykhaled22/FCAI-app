// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestaurantsModelAdapter extends TypeAdapter<RestaurantsModel> {
  @override
  final int typeId = 1;

  @override
  RestaurantsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestaurantsModel(
      name: fields[0] as String,
      address: fields[1] as String,
      distance: fields[2] as double,
      category: fields[3] as String,
      latitude: fields[5] as double,
      longitude: fields[6] as double,
      image: fields[7] as String,
      products: (fields[8] as List).cast<ProductModel>(),
      isFav: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RestaurantsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.distance)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.isFav)
      ..writeByte(5)
      ..write(obj.latitude)
      ..writeByte(6)
      ..write(obj.longitude)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
