import 'package:analyzer/dart/analysis/features.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lab2_2/model/ORMconfiguration.dart';
import 'package:lab2_2/src/Home/Views/HomeView.dart';
import 'package:lab2_2/src/app/Controllers/PhoneAppController.dart';
import 'package:lab2_2/src/app/Models/PhoneList.dart';
import 'package:mvc_application/controller.dart';

class HomeController extends ControllerMVC {
  factory HomeController() {
    _this ??= HomeController._();
    return _this;
  }

  HomeController._();
  static HomeController _this;


  @override
  void initState() {
    _widget = _Widgets(this);
    _title = _Titles(this);
    _onTaps = OnTaps(this);
  }

  @override
  void dispose() {
    _this = null;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _widget.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  _Titles get tittle => _title;
  _Titles _title;

  _Widgets get widget => _widget;
  _Widgets _widget;

  OnTaps get onTap => _onTaps;
  OnTaps _onTaps;

  BuildContext get context => this.stateMVC.context;

  Widget buildAppBar() {
    return AppBar(
      elevation: 0.0,
      title: _widget.appBarTitle,
      actions: <Widget>[
        _widget.search,
        _widget.popMenu,
      ],
      bottom: TabBar(
        tabs: <Widget>[
          _widget.home,
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return AppBar(
      leading: BackButton(
        color: Theme.of(context).accentColor,
      ),
      title: TextField(
        controller: _searchQuery,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Search phone models',
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
    );
  }

  Widget buildPhoneTab(
      BuildContext context, HomeViewTab tab, List<Phone> phones, List<bool> isPress) {

    return AnimatedBuilder(
      key: ValueKey<HomeViewTab>(tab),
      animation: Listenable.merge(
          <Listenable>[_searchQuery, PhoneAppController.phoneData]),
      builder: (BuildContext context, Widget child) {
        return _buildPhonesList(
            context,
            _filterBySearchQuery(phones),
            isPress,
            tab);
      },
    );
  }

  Widget _buildPhonesList(
      BuildContext context, Iterable<Phone> phones, List<bool> isPressed, HomeViewTab tab) {
    return PhoneList(
      phones: phones.toList(),
      isPress: isPressed,
      onAction: (Phone phone, bool isPress, int index) {
        setState(() {
          isPressed[index] = !isPressed[index];
        });
        print(isPress);
        },
      onOpen: (Phone phone, bool isPress, int index) {
        Navigator.pushNamed(context, '/edit', arguments: phone.id);
      },
    );
  }

  Iterable<Phone> _filterBySearchQuery(Iterable<Phone> phones) {
    if(_searchQuery.text.isEmpty) return phones;
    final RegExp regExp = RegExp(_searchQuery.text, caseSensitive: false);
    return phones.where((Phone phone) => phone.phoneModel.contains(regExp));
  }


  void _handleSearchBegin() {
    ModalRoute.of(context).addLocalHistoryEntry(LocalHistoryEntry(
      onRemove: () {
        setState(() {
          _isSearching = false;
          _searchQuery.clear();
        });
      },
    ));
    setState(() {
      _isSearching = true;
    });
  }
}

class _Titles { //i think that is a controller or sth like that
  _Titles(this.con);
  HomeController con;

  //There should be probably a widgets with titles of page i think?
  Widget HomeView = const Text('Phones');
}

class _Widgets {
  _Widgets(this.con) {
    listTitles = _ListTitles(con);
    _appBar = _AppBar(con);
    _drawer = _Drawer(con);
    _body = _Body(con);
  }

  HomeController con;
  _ListTitles listTitles;
  _AppBar _appBar;
  _Drawer _drawer;
  _Body _body;
  _FloatingActionButton _floatingButton;
  _DeletePhonePanel _deletePhonePanel;

  Widget get drawer => _drawer.drawer;
  Future<Widget> get body async => await _body.body;
  Widget get appBarTitle => _appBar.appBarTitle;
  Widget get appBar => _isSearching ? con.buildSearchBar(): con.buildAppBar();
  Widget get phonesList => listTitles.phonesList;
  Widget get search => _appBar.search;
  Widget get popMenu => _appBar.popMenu;
  Widget get home => _appBar.home;
  Widget get deletePhonePanel => _deletePhonePanel.deletePhonePanel;
  //There should be probably another components

  void didChangeDependencies() {
    _deletePhonePanel = _DeletePhonePanel(con);
    _floatingButton = _FloatingActionButton(con);
    _appBar.homeStrings();
    //there probably could be inject dependencies to this
  }
  List<bool> isPress = new List<bool>();
  var isBuild = false;

  Widget get homePhonesTab {

    return new FutureBuilder(
      future: PhoneAppController.phoneData.allPhones,
      initialData: new List<Phone>(),
      builder: (BuildContext context, AsyncSnapshot<List<Phone>> phones) {


        if(isBuild == false && phones.data != null && phones.data.length > isPress.length ) {
          for(int i = isPress.length; i < phones.data.length ; i++){
            isPress.add(false);
          }
          isBuild = true;
        }

        return con.buildPhoneTab(con.context, HomeViewTab.home, phones.data, isPress);
      },
    );
  }
  _FloatingActionButton get floatingButton => _floatingButton;
}

class _AppBar {
  _AppBar(this.con) {
    popMenu = PopupMenuButton(itemBuilder: (BuildContext context) {},);
    search = IconButton(
      icon: const Icon(Icons.search),
      onPressed: con._handleSearchBegin,
      tooltip: 'Search',
    );
  }
    HomeController con;
    PopupMenuButton<Widget> popMenu;
    IconButton search;
    Tab home;
    Text appBarTitle;
    Widget _deletePhonePanel;

    void homeStrings() {
      home = Tab(text: "home");
      appBarTitle = Text("Phone dictionnary");
    }
}

class _FloatingActionButton {
  _FloatingActionButton(HomeController con) {
    _addNewPhone = FloatingActionButton(
      tooltip: 'Create Phone',
      child: const Icon(Icons.add),
      backgroundColor: Theme.of(con.context).accentColor,
      onPressed: () {
        Navigator.pushNamed(con.context, '/edit', arguments: null);
      },
    );
  }

  FloatingActionButton get addNewPhone => _addNewPhone;
  FloatingActionButton _addNewPhone;
}

class _ListTitles { //This is menu from left page
  _ListTitles(this.con);
  HomeController con;

  ListTile phonesList = const ListTile(
    leading: Icon(Icons.phone),
    title: Text('Phones'),
    selected: true,
  );
}

class OnTaps {
  OnTaps(this.con);
  HomeController con;
}

class _Drawer { //thats the left panel of the widget
  _Drawer(this.con);
  HomeController con;

  Widget get drawer => Drawer(
    child: ListView(
      dragStartBehavior: DragStartBehavior.down,
      children: <Widget>[
        const DrawerHeader(child: Center(child: Text('Phones'))),
        con.widget.phonesList
      ],
    ),
  );
}

class _Body {
  _Body(this.con);

  HomeController con;

  Future<Widget> get body async =>
      TabBarView(
        dragStartBehavior: DragStartBehavior.down,
        children: <Widget>[
          con.widget.homePhonesTab
        ],
      );
}

class _DeletePhonePanel{
  _DeletePhonePanel(this.con);
  HomeController con;

  Widget get deletePhonePanel {
    if(getIndexOfPressedElements(con.widget.isPress).length > 0)
    return Container(
        child: new ButtonBar(
          children: <Widget>[
            new RaisedButton(onPressed: () => cleanPressElement(con.widget.isPress), child: Text("revoke")),
            new RaisedButton(onPressed: null, child: Text("delete"))
          ],
        )
    );
    else return null;
  }

  void cleanPressElement(List<bool> isPressed) {
    for(int i = 0 ; i < isPressed.length ; i++){
      con.setState(() {isPressed[i] = false; });
    }
  }


  void deletePressedElements(List<bool> isPressed){

  }

  List<int> getIndexOfPressedElements(List<bool> isPressed){
    List<int> pressedElementsId = new List<int>();

    for(int i = 0 ; i < isPressed.length ; i++)
      if (isPressed[i])
        pressedElementsId.add(i);
    return pressedElementsId;
  }

}

final TextEditingController _searchQuery = TextEditingController();
bool _isSearching = false;