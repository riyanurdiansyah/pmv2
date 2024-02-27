import 'dart:convert';

SidebarEntity sidebarEntityFromJson(String str) =>
    SidebarEntity.fromJson(json.decode(str));

String sidebarEntityToJson(SidebarEntity data) => json.encode(data.toJson());

class SidebarEntity {
  final String route;
  final String id;
  final List<int> role;
  final String title;
  // final String created;
  // final String updated;
  final List<SidebarEntity> submenus;

  SidebarEntity({
    required this.route,
    required this.id,
    required this.role,
    required this.title,
    // required this.created,
    // required this.updated,
    required this.submenus,
  });

  SidebarEntity copyWith({
    String? route,
    String? id,
    List<int>? role,
    String? title,
    String? created,
    String? updated,
    List<SidebarEntity>? submenus,
  }) =>
      SidebarEntity(
        route: route ?? this.route,
        id: id ?? this.id,
        role: role ?? this.role,
        title: title ?? this.title,
        // created: created ?? this.created,
        // updated: updated ?? this.updated,
        submenus: submenus ?? this.submenus,
      );

  factory SidebarEntity.fromJson(Map<String, dynamic> json) => SidebarEntity(
        route: json["route"] ?? "",
        id: json["id"] ?? "",
        role: json["role"] == null
            ? []
            : List<int>.from(json["role"].map((x) => x)),
        title: json["title"] ?? "",
        // created: json["created"] ?? "",
        // updated: json["updated"] ?? "",
        submenus: json["submenus"] == null
            ? []
            : List<SidebarEntity>.from(
                json["submenus"].map((x) => SidebarEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "route": route,
        "id": id,
        "role": List<dynamic>.from(role.map((x) => x)),
        "title": title,
        // "created": created,
        // "updated": updated,
        "submenus": List<SidebarEntity>.from(submenus.map((e) => e.toJson())),
      };
}
