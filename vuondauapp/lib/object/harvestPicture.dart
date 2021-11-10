class HarvestPicture {
  String id;
  String src;
  String alt;

  HarvestPicture({required this.id, required this.src, required this.alt});

  factory HarvestPicture.fromJson(Map<String, dynamic> json) {
    return HarvestPicture(
        id: json['id'],
        src: json['src'],
        alt: json['alt']
    );
  }
}

class ListHarvestPicture{
  final List<HarvestPicture> harvests;

  ListHarvestPicture({required this.harvests});

  factory ListHarvestPicture.fromJson(List<dynamic> parsedJson) {

    List<HarvestPicture> harvests = parsedJson.map((i)=>HarvestPicture.fromJson(i)).toList();
    return new ListHarvestPicture(
      harvests: harvests,
    );
  }
}