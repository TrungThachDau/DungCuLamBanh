import 'package:flutter/material.dart';
import 'package:whiskflourish/screens/detail_screen.dart';
import 'package:whiskflourish/services/detail_product_service.dart';
import 'package:whiskflourish/services/product_service.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  //Goi Service de lay danh sach san pham
  final ProductService productService = ProductService();
  late Future<List<Product>> futureProducts;
  @override
  void initState() {
    super.initState();
    futureProducts = productService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
 

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          futureProducts = productService.getProducts();
        });
      },
      child:FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return GestureDetector(
                    onTap: () async {
                      //Mở detail screen khi click vào sản phẩm
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            productService: DetailProductService(),
                            product: product,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      elevation: 0,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                product.image,
                                width: double
                                    .infinity, // Fixed height for the image
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 0),
                            Padding(
                              //padding==0

                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),

                              child: Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                                    child: product.pricesale == 0
                                      ? Text(
                                          "${product.price.round()}₫",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFE91E63),
                                          ),
                                        )
                                      : RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "${product.price.round()}₫",
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                              const TextSpan(text: " "),
                                              TextSpan(
                                                text: "${product.pricesale.round()}₫",
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFE91E63),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
