import 'package:cupertinostore/model/app_state_model.dart';
import 'package:cupertinostore/product_row_item.dart';
import 'package:cupertinostore/search_bar.dart';
import 'package:cupertinostore/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController _searchController;
  String _searchTerm = '';
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _searchTerm = _searchController.text;
    });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SearchBar(
        controller: _searchController,
        focusNode: _focusNode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final result = model.search(_searchTerm);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: Column(
        children: [
          SizedBox(height: 56,),
          _buildSearchBox(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => ProductRowItem(
                product: result[index],
                index: index,
                lastItem: index == result.length - 1,
              ),
              itemCount: result.length,
            ),
          ),
        ],
      ),
    );
  }
}
