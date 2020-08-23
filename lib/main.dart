import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIform(),
    theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIformState();
  }
}

class _SIformState extends State<SIform> {
  String nameCity = "";
  var _currencies = ["Rupees", "Dollar", "Pounds"];
  var _currentItemSelected = '';
  var _formKey = GlobalKey<FormState>();
  final _minimalPadding = 5.0;
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = "";

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
//      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Simple Intrest Calculator"),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimalPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimalPadding, bottom: _minimalPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: principalController,
                      style: textStyle,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Plese enter principal amount";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Principal",
                          labelStyle: textStyle,
                          hintText: "Enter the Principal e.g. 1200",
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(52.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimalPadding, bottom: _minimalPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      style: textStyle,
                      validator: (String value) {
                        if (value.isEmpty ) {
                          return "Plese enter principal amount";
                        }
                      },
                      controller: roiController,
                      decoration: InputDecoration(
                          labelText: "Rate Of Intrest",
                          labelStyle: textStyle,
                          hintText: "In Percentage",
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(52.0))),
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      style: textStyle,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Plese enter principal amount";
                        }
                      },
                      controller: termController,
                      decoration: InputDecoration(
                          labelText: "Term",
                          labelStyle: textStyle,
                          hintText: "Time in years",
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(52.0))),
                    )),
                    Container(
                      width: _minimalPadding * 5,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValueSelected) {
                        setState(() {
//                      this._currentItemSelected = newValueSelected;
                          _onDropDownItemSelected(newValueSelected);
                        });
                      },
                    )),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimalPadding, top: _minimalPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate())
                                this.displayResult = _calculateTotalReturns();
                            });
                          },
                        )),
                        Container(
                          width: _minimalPadding * 3,
                        ),
                        Expanded(
                            child: RaisedButton(
                          textColor: Theme.of(context).accentColor,
                          color: Theme.of(context).primaryColorDark,
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ))
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimalPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/ticket.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimalPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        "after $term years, your investment will worth $totalAmountPayable $_currentItemSelected";
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
/*//import 'package:flutter/material.dart';
//
//void main() {
//  runApp(MaterialApp(title: "Statefull widget", home: FavoriteCity()));
//}
//
//class FavoriteCity extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return _FavoriteCityState();
//  }
//}
//
//class _FavoriteCityState extends State<FavoriteCity> {
//  String nameCity = "";
//  var _currenciees = ["Rupees", "Dollar", "Pounds", "younan"];
//  var _currentItemSelected="Rupees";
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    debugPrint("Favorite City widget is created");
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("kushal is here"),
//      ),
//      body: Container(
//        margin: EdgeInsets.all(32.0),
//        child: Column(
//          children: <Widget>[
//            Padding(padding: EdgeInsets.all(2.2), child: TextField(
//              onChanged: (String userInput) {
//                setState(() {
//                  debugPrint("set State is called");
//                  nameCity = userInput;
//                });
//              },
//            )),
//            DropdownButton<String>(
//                items: _currenciees.map((String dropDownStringItem) {
//                  return DropdownMenuItem<String>(value: dropDownStringItem,
//                    child: Text(dropDownStringItem),);
//                }).toList(),
//              onChanged: (String newValueSelected){
//                  setState(() {
//                    this._currentItemSelected=newValueSelected;
//                  });
//              },
//              value: _currentItemSelected,
//            ),
//            Padding(padding: EdgeInsets.all(2.2),
//                child: Text(
//                  "your best city is $nameCity",
//                  style: TextStyle(
//                    fontSize: 43.0,
//                  ),
//                ))
//          ],
//        ),
//      ),
//    );
//  }
//}
*/
