class Location {
  final String city;
  final String state;


  Location(this.city, this.state);

  Location.fromJson(Map<String, dynamic> json)
      :
        city = json["city"],
        state = json["state"];
}