import 'dart:convert';

class Category {
  String name;
  String description;
  String icon;

  Category({
    this.name,
    this.description,
    this.icon,
  });

  Category copyWith({
    String name,
    String description,
    String icon,
  }) {
    return Category(
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'icon': icon,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Category(
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
  String toString() => 'Category(name: $name, description: $description, icon: $icon)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Category &&
      o.name == name &&
      o.description == description &&
      o.icon == icon;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode ^ icon.hashCode;
}
