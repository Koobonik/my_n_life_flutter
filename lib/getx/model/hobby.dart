class Hobby{
  int id;
  String name;
  String? largeCategory;
  String? mediumCategory;
  String? smallCategory;
  String mainColor;
  String mainImage;

//<editor-fold desc="Data Methods">

  Hobby({
    required this.id,
    required this.name,
    this.largeCategory,
    this.mediumCategory,
    this.smallCategory,
    required this.mainColor,
    required this.mainImage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hobby &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          largeCategory == other.largeCategory &&
          mediumCategory == other.mediumCategory &&
          smallCategory == other.smallCategory &&
          mainColor == other.mainColor &&
          mainImage == other.mainImage);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      largeCategory.hashCode ^
      mediumCategory.hashCode ^
      smallCategory.hashCode ^
      mainColor.hashCode ^
      mainImage.hashCode;

  @override
  String toString() {
    return 'Hobby{' +
        ' id: $id,' +
        ' name: $name,' +
        ' largeCategory: $largeCategory,' +
        ' mediumCategory: $mediumCategory,' +
        ' smallCategory: $smallCategory,' +
        ' mainColor: $mainColor,' +
        ' mainImage: $mainImage,' +
        '}';
  }

  Hobby copyWith({
    int? id,
    String? name,
    String? largeCategory,
    String? mediumCategory,
    String? smallCategory,
    String? mainColor,
    String? mainImage,
  }) {
    return Hobby(
      id: id ?? this.id,
      name: name ?? this.name,
      largeCategory: largeCategory ?? this.largeCategory,
      mediumCategory: mediumCategory ?? this.mediumCategory,
      smallCategory: smallCategory ?? this.smallCategory,
      mainColor: mainColor ?? this.mainColor,
      mainImage: mainImage ?? this.mainImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'largeCategory': this.largeCategory,
      'mediumCategory': this.mediumCategory,
      'smallCategory': this.smallCategory,
      'mainColor': this.mainColor,
      'mainImage': this.mainImage,
    };
  }

  factory Hobby.fromMap(Map<String, dynamic> map) {
    return Hobby(
      id: map['id'] as int,
      name: map['name'] as String,
      largeCategory: map['largeCategory'] as String?,
      mediumCategory: map['mediumCategory'] as String?,
      smallCategory: map['smallCategory'] as String?,
      mainColor: map['mainColor'] as String,
      mainImage: map['mainImage'] as String,
    );
  }

//</editor-fold>
}