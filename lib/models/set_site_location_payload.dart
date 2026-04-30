class SetSiteLocationPayload {
  int? id;
  int? projectid;
  String? latitude;
  String? longitude;
  String? address;
  int? radius;

  SetSiteLocationPayload({
    this.id ,
    this.projectid ,
    this.latitude,
    this.longitude,
    this.address,
    this.radius,
  });


  Map<String, dynamic> toJson() => {
    "id": id,
    "projectId": projectid,
    "latitude": latitude.toString(),
    "longitude": longitude.toString(),
    "projectAddress": address.toString(),
    "radius": radius,
  };
}
