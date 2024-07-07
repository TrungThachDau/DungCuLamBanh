import 'package:flutter/material.dart';
import 'package:whiskflourish/screens/detail_screen.dart';
import 'package:whiskflourish/services/detail_product_service.dart';
import 'package:whiskflourish/services/product_service.dart';

class MainScreenScreen extends StatefulWidget {
  const MainScreenScreen({super.key});

  @override
  State<MainScreenScreen> createState() => _MainScreenScreenState();
}

class _MainScreenScreenState extends State<MainScreenScreen> {
  //Goi Service de lay danh sach san pham
  final ProductService productService = ProductService();
  late Future<List<Product>> futureSaleOffProducts;
  late Future<List<Product>> futureNewProducts;
  @override
  void initState() {
    super.initState();
    futureSaleOffProducts = productService.getSaleOffProducts();
    futureNewProducts = productService.getNewProduct();
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          futureSaleOffProducts = productService.getSaleOffProducts();
          futureNewProducts =  productService.getNewProduct();
        });
      },
      
      child: FutureBuilder<List<Product>>(       
        future: futureSaleOffProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: SizedBox(
                        width: 200,
                        height: 200, // Fixed height for the card
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/qldclb-770f5.appspot.com/o/Pink%20and%20Brown%20Cute%20Opening%20Soon%20Banner.gif?alt=media&token=67a067f5-7ba9-4240-a4bc-8049db56ab5a',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      'GIẢM GIÁ DÀNH CHO BẠN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = snapshot.data![index];
                      return GestureDetector(
                        onTap: () async {
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

                                  padding:
                                      const EdgeInsets.fromLTRB(10, 3, 10, 0),

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
                    childCount: snapshot.data!.length,
                  ),
                ),
                
                
                
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      
    );
    
  }
}
