import 'package:flutter/material.dart';
import './product_edit.dart';
import './product_list.dart';
import '../scoped_models/main.dart';

class ProductsAdminPage extends StatelessWidget {


  final MainModel model;


  ProductsAdminPage(this.model);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage your products'),
          bottom: _buildTabBar(),
        ),
        body: TabBarView(
          children: <Widget>[ProductEditPage(), ProductListPage(model)],
        ),
      ),
    );
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop_two),
            title: Text('Back to the List'),
            onTap: () => Navigator.pushReplacementNamed(context, '/products'),
          )
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          text: 'Create Product',
          icon: Icon(Icons.create),
        ),
        Tab(
          text: 'My Products',
          icon: Icon(Icons.list),
        )
      ],
    );
  }
}
