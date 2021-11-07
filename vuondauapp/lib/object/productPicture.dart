class ProductPicture{
  final String id;
  final String src;

  ProductPicture({required this.id, required this.src});
  
  factory ProductPicture.fromJson(Map<String, dynamic> json){
    return  ProductPicture(
        id:json['id'],
        src:json['src']
    );
  }
}

class ListProductPictures{
  final List<ProductPicture> products;

  ListProductPictures({required this.products});

  factory ListProductPictures.fromJson(List<dynamic> parsedJson) {

    List<ProductPicture> products = parsedJson.map((i)=>ProductPicture.fromJson(i)).toList();
    return new ListProductPictures(
      products: products,
    );
  }
}