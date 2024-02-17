import 'package:flutter/material.dart';
import 'package:flutter_assmnts/services/services.dart';
import 'package:flutter_assmnts/utils/const.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ItemListWidget extends StatefulWidget {
  const ItemListWidget({super.key});

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  final ScrollController _scrollController = ScrollController();
  final ApiProvider _apiProvider = ApiProvider();
  final List<Items> _items = [];
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isLoading = false;

  @override
  void initState() {

    _fetchItems();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
        _fetchItems();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _fetchItems() async {
    setState(() {
      _isLoading = true;
    });
    List<Items> newItems = await _apiProvider.fetchItems(_currentPage, _pageSize);
    setState(() {
      _isLoading = false;
      _items.addAll(newItems);
      _currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Together',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: primaryColor
      ),
      body: ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: _isLoading ? _items.length + 1 : _items.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < _items.length) {
            Items item = _items[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 3,top: 6,left: 6,right: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: primaryColor,width: 0.25 )
                ),
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.description),
                  leading: ClipRRect(child: Image.network(item.image_url, fit: BoxFit.contain),borderRadius: BorderRadius.circular(10),)
                  
                ),
              ),
            );
          } else {
            return  Center(child: LoadingAnimationWidget.stretchedDots(
              size: 40,
              color: primaryColor,
            ),);
          }
        },
      ),
    );
  }
}
