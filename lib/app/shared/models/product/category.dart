import 'dart:convert';

class Category {
  String id;
  String name;
  String description;
  String icon;

  Category({
    this.id,
    this.name,
    this.description,
    this.icon,
  });

  Category copyWith({
    String id,
    String name,
    String description,
    String icon,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      icon: map['icon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => 
    Category.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() => 'Category(id: $id, name: $name, description: $description, icon: $icon)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Category &&
      o.id == id &&
      o.name == name &&
      o.description == description &&
      o.icon == icon;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode ^ icon.hashCode;
}
