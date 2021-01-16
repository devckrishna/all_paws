class User0 {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;
  String password;
  String about;
  String gender;
  String interestedIn;
  String age;

  User0(
      {this.uid,
      this.name,
      this.email,
      this.username,
      this.status,
      this.state,
      this.profilePhoto,
      this.password,
      this.about,
      this.age,
      this.gender,
      this.interestedIn});

  Map toMap(User0 user, String about, String age, String gender,
      String interestedIn) {
    var data = Map<String, dynamic>();
    data["uid"] = user.uid;
    data["name"] = user.name;
    data["email"] = user.email;
    data["username"] = user.username;
    data["state"] = user.state;
    data["status"] = user.status;
    data["profilePhoto"] = user.profilePhoto;
    data["password"] = user.password;
    data["about"] = about;
    data["age"] = age;
    data["gender"] = gender;
    data["interestedIn"] = interestedIn;
    return data;
  }

  User0.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData["uid"];
    this.name = mapData["name"];
    this.email = mapData["email"];
    this.username = mapData["username"];
    this.state = mapData["state"];
    this.status = mapData["status"];
    this.profilePhoto = mapData["profilePhoto"];
    this.password = mapData["password"];
  }
}
