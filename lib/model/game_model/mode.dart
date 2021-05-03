class ModeModel{
  final int id;
  final String name;

  ModeModel(this.id,this.name);

  ModeModel.fromJSON(Map<String,dynamic> json):
      id = json["id"],
      name = json["name"];
}