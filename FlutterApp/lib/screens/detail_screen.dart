import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whiskflourish/services/detail_product_service.dart';
import 'package:whiskflourish/services/product_service.dart';

class DetailScreen extends StatefulWidget {
final DetailProductService productService;
final Product product;
const DetailScreen({super.key, required this.productService, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<ProductDetail> futureProductDetail;

  @override
  void initState() {
    super.initState();
    futureProductDetail = widget.productService.getProductDetail(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            showMenu(
              context: context,
              position: const RelativeRect.fromLTRB(1000, 70, 0, 0), // you might need to adjust these values
              items: [
                const PopupMenuItem(
                  value: 'facebook',
                  child: Text('Chia sẻ qua Facebook'),
                ),
                // const PopupMenuItem(
                //   value: 'twitter',
                //   child: Text('Chia sẻ qua Twitter'),
                // ),
                // Add more PopupMenuItems if needed
              ],
            ).then((value) async {
              if (value != null) {
                // Handle the value returned from the popup menu
                print('Chia sẻ qua $value');
              }
              if(value == 'facebook'){
                final url = 'https://www.facebook.com/sharer/sharer.php?u=http://35.223.233.219/Product/Detail/${widget.product.id}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              }
            });
            
            // Thêm hành động khi người dùng nhấp vào nút chia sẻ
          },
        ),         
        ],
        // title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<ProductDetail>(
            future: futureProductDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ProductDetail product = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), // Adjust the radius to change how rounded the corners are
                      child: Image.network(product.imageUrl),
                    ),
                    Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('${product.price.round()}₫', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.red)),
                    Text(product.category, style: const TextStyle(fontSize: 16)),
                    Text(product.moreInfo, style: const TextStyle(fontSize: 16)),
                    //add line 
                    const SizedBox(height: 10),
                    //add button 'Add to cart'
                    ElevatedButton(
                      onPressed: () {

                      // Add product to cart
                      },
                      child: const Text(
                      'Thêm vào giỏ hàng',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 20,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),
                    
                    //Share to facebook
                    
                    //tao khoang trong
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                      'Chi tiết sản phẩm',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    //add description
                    Text(product.description, style: const TextStyle(fontSize: 16)),

                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}