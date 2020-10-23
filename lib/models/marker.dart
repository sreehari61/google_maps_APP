class MarkerModel{
  int id;
  double latitude;
  double longitude;
  int userId;

  MarkerModel(double lat, double lng,int userId){
    this.latitude = lat;
    this.longitude = lng;
    this.userId = userId;
  }

  MarkerModel.fromMap(Map<String,dynamic> map){
    this.id = map['markerId'];
    this.latitude= map['latitude'];
    this.longitude = map['longitude'];
    this.userId = map['userId'];
  }

}