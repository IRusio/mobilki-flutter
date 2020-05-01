class Phone {
  int _id;
  String _producer;
  String _phoneModel;
  double _androidVersion;
  String _phoneWebPage;


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Phone();

  Phone.phone(this._id, this._producer, this._phoneModel, this._androidVersion,
      this._phoneWebPage);

  String get producer => _producer;

  set producer(String value) {
    _producer = value;
  }

  String get phoneModel => _phoneModel;

  set phoneModel(String value) {
    _phoneModel = value;
  }

  double get androidVersion => _androidVersion;

  set androidVersion(double value) {
    _androidVersion = value;
  }

  String get phoneWebPage => _phoneWebPage;

  set phoneWebPage(String value) {
    _phoneWebPage = value;
  }


}