import 'dart:convert';

List<FeedModel> feedModelFromJson(String str) => List<FeedModel>.from(json.decode(str).map((x) => FeedModel.fromJson(x)));

String feedModelToJson(List<FeedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedModel {
    FeedModel({
        this.name,
        this.profile,
        this.comment,
        this.commentphoto,
    });

    String? name;
    String? profile;
    String? comment;
    String? commentphoto;

    factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        name: json["name"],
        profile: json["profile"],
        comment: json["comment"],
        commentphoto: json["commentphoto"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "profile": profile,
        "comment": comment,
        "commentphoto": commentphoto,
    };
}
