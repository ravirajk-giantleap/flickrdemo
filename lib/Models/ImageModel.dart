
import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel  {
    ImageModel({
         this.title,
         this.link,
         this.description,
         this.modified,
         this.generator,
         this.items,
    });

    String? title;
    String?link;
    String? description;
    DateTime? modified;
    String? generator;
    List<Item>? items;

    factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        title: json["title"],
        link: json["link"],
        description: json["description"],
        modified: DateTime.parse(json["modified"]),
        generator: json["generator"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "description": description,
        "modified": modified?.toIso8601String(),
        "generator": generator,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    
    String? title;
    String? link;
    Media? media;
    DateTime? dateTaken;
    String? description;
    DateTime? published;
    String? author;
    String? authorId;
    String? tags;
    double? ratings;
    String? name;
    String? reason;
    Item({
        this.name,
        this.reason,
        this.title,
        this.link,
        this.media,
        this.dateTaken,
        this.description,
        this.published,
        this.author,
        this.authorId,
        this.tags,
        this.ratings
    });


    factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        link: json["link"],
        media: Media.fromJson(json["media"]),
        dateTaken: DateTime.parse(json["date_taken"]),
        description: json["description"],
        published: DateTime.parse(json["published"]),
        author: json["author"],
        authorId: json["author_id"],
        tags: json["tags"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "media": media?.toJson(),
        "date_taken": dateTaken?.toIso8601String(),
        "description": description,
        "published": published?.toIso8601String(),
        "author": author,
        "author_id": authorId,
        "tags": tags,
    };
}

class Media {
    Media({
        this.m,
    });

    String? m;

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        m: json["m"],
    );

    Map<String, dynamic> toJson() => {
        "m": m,
    };
}
