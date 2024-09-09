import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub/pages/product_detail_screen.dart';
import 'package:shop_hub/providers/search_page_provider.dart';
import 'package:shop_hub/utils/helper_functions/helper_functions.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: Consumer<SearchProvider>(
        builder: (_, provider, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.white)),
              title: TextField(
                controller: provider.searchController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search Products',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                onSubmitted: (String? value) {
                  if(value == null || value.isEmpty){
                    return;
                  }else{
                    provider.searchProducts(value);
                    provider.addSearchHistory(value);
                  }
                },
                onChanged: (value) {
                  provider.setNullSearchList(value);
                },
              ),
              actions: [
                GestureDetector(
                  onTap: (){
                    provider.searchController.text = '';
                    provider.setNullSearchList(provider.searchController.text);
                  },
                    child: const Icon(Icons.clear, color: Colors.white)),
                const SizedBox(width: 15),
              ],
            ),
            body: provider.searchController.text.isEmpty
                ? provider.searchHistory.isNotEmpty
                ? ListView.builder(
              itemCount: provider.searchHistory.length,
              itemBuilder: (_, index) {
                final historyItem = provider.searchHistory[index];
                return ListTile(
                  trailing: IconButton(
                    onPressed: () {
                      provider.removeSearchHistory(historyItem);
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  title: Text(
                    historyItem,
                    style: const TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    provider.searchController.text = historyItem;
                    provider.searchProducts(historyItem);
                  },
                );
              },
            )
                : const Center(child: Text('No Recent Searches'))
                : provider.search!.isNotEmpty
                ? ListView.builder(
              itemCount: provider.search?.length ?? 0,
              itemBuilder: (_, index) {
                final searchResult = provider.search?[index];
                return ListTile(
                  onTap: () {
                    HelperFunctions.navigateToScreen(
                      ProductDetailScreen(
                        productId: '${searchResult?.productId}',
                        category: '${searchResult?.category}',
                      ),
                      context,
                    );
                  },
                  leading: CachedNetworkImage(
                    imageUrl: '${searchResult?.image}',
                    fit: BoxFit.fill,
                    placeholder: (_, url) => const Icon(Icons.image),
                  ),
                  title: Text('${searchResult?.name}'),
                  subtitle: Text(
                    "${searchResult?.price} Ks",
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              },
            )
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
