import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_state.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';

import 'package:flutter/material.dart';

/*class ProductGridScreen extends StatelessWidget {
  const ProductGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example product list
    final List<Map<String, String>> products = [
      {
        "title": "Bodycron Bermu",
        "category": "Others",
        "image": "assets/product2-removebg-preview.png",
      },
      {
        "title": "Stylish Dress",
        "category": "Fashion",
        "image": "assets/product2-removebg-preview.png",
      },
      {
        "title": "Winter Jacket",
        "category": "Clothing",
        "image": "assets/product2-removebg-preview.png",
      },
      {
        "title": "Casual Shoes",
        "category": "Footwear",
        "image": "assets/product2-removebg-preview.png",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Grid"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items in a row
            childAspectRatio: 0.65, // Adjust card height
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              title: products[index]["title"]!,
              category: products[index]["category"]!,
              image: products[index]["image"]!,
            );
          },
        ),
      ),
    );
  }
}

// Reusable Product Card
class ProductCard extends StatefulWidget {
  final String title;
  final String category;
  final String image;

  const ProductCard({
    super.key,
    required this.title,
    required this.category,
    required this.image,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image + Favorite Icon
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  widget.image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
           
            ],
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                // Increment/Decrement Row instead of Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        if (quantity > 0) {
                          setState(() => quantity--);
                        }
                      },
                    ),
                    Text(
                      "$quantity",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() => quantity++);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  widget.category,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                // Add to Bag Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Add to cart logic
                    },
                    icon: const Icon(Icons.shopping_cart, size: 18),
                    label: const Text(
                      "Add to Bag",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/


class TakeOrderScreen extends StatefulWidget {
  const TakeOrderScreen({super.key});

  @override
  State<TakeOrderScreen> createState() => _TakeOrderScreenState();
}

class _TakeOrderScreenState extends State<TakeOrderScreen> {
  String searchQuery = "";
    int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:context.read<GlobalBloc>().state.loginModel!.items!.length != 0 ? AppBar(
backgroundColor: Colors.white,
        centerTitle: true,
              title: GradientText("Products", fontSize: 24),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search Products",
                prefixIcon: Icon(Icons.search),
               // border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        )):AppBar(
       backgroundColor: Colors.transparent,
        centerTitle: true,
              title: GradientText("Products", fontSize: 24),
    
      ),
      body: Column(
        children: [

          Expanded(
            child: BlocBuilder<GlobalBloc, GlobalState>(
              builder: (context, state) {
                if (state.status== LoginStatus.success &&
                    state.loginModel!.items!.isNotEmpty) {
                  final items =   state.loginModel!.items!;
                  final filteredItems = items.where((item) {
                    final name = item.name.toString().toLowerCase() ?? '';
                    final itemName = item.itemName!.toLowerCase() ?? '';
                    final itemDescription = item.itemDesc!.toLowerCase() ?? "";
                    return name.contains(searchQuery) || itemName.contains(searchQuery) 
                        ;
                  }).toList();
            
                  if (filteredItems.isEmpty) {
                    return const Center(child: Text("No items found"));
                  }
                  return ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItems[index].itemName.toString(),style: TextStyle(fontSize: 14), ),
                        subtitle: Column(
                          children: [
                            Text(filteredItems[index].itemDesc.toString(),style: TextStyle(fontSize: 13,color: Colors.grey)),
                            Row(
                              children: [
                                Text('Qty : ',style: TextStyle(fontSize: 16)),
                                InkWell(
          onTap: () {
            setState(() {
              if (count > 0) count--;
            });
          },
          child: Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.redAccent,
            ),
            child: const Icon(Icons.remove, color: Colors.white, size: 15),
          ),
        ),
        const SizedBox(width: 12),

        // Counter Text
        Text(
          "$count",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(width: 12),

        // Increment Button
        InkWell(
          onTap: () {
            setState(() {
              count++;
            });
          },
          child: Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 15),
          ),
        ),
                              ],
                            ),
                            
                          ],
                        ),
                        leading: Container(
                          child: Image.asset(
                             width: 70,
              height: 200,
                            filteredItems[index].itemName!.contains('ULTRA RICH')
                                ? "assets/product2-removebg-preview.png"
                                : filteredItems[index].itemName!.contains('HARDAM MIXTURE')
                                    ? "assets/product4-removebg-preview.png"
                                    : filteredItems[index].itemName!.contains('HARDUM - TEA')
                                    ? "assets/product1-removebg-preview.png"
                                     : filteredItems[index].itemName!.contains('HARDUM DANEDAR')
                                    ? "assets/product3-removebg-preview.png"
                                       : filteredItems[index].itemName!.contains('BAITHAK')
                                    ? "assets/mezan_baithak-removebg-preview.png"
                                    : 'assets/product5-removebg-preview.png',
                                   fit: BoxFit.cover,
                          ),
                        ),
            
                      );
                    },
                  );
                } else {
                  return const Center(
                    child:Text('No PJP Available!') //CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}