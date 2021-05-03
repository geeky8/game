class ScreenShotModel{
  final int id;
  final String imageId;

  ScreenShotModel(this.id,this.imageId);

  ScreenShotModel.fromJSON(Map<String,dynamic> json):
      id = json["id"],
      imageId = json["image_id"];
}