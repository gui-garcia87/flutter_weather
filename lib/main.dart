import 'package:flutter/material.dart';
import 'package:flutter_weather/Weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:transparent_image/transparent_image.dart';





void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;



  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final String urlApi = "http://api.openweathermap.org/data/2.5/weather?q=";

  final String keyApi = "&units=metric&appid=7c179a04ba87c9186a8952f181e5369a";

  final String urlApiImg = 'http://openweathermap.org/img/w/';

  Weather weatherClass =  new Weather();

  String urlImg;
  String txt;
  String city;

  Future<String> getData() async{

    String u;
    ste(u);
    Map<String, dynamic> resBody;
    print(resBody);


    String urlCity =  urlApi + city + keyApi;

    http.Response response = await http.get(

      Uri.encodeFull(urlCity),
      headers: {
        "Accept": "application/json"
      }
    );

    int code = response.statusCode;
    print(code);

    if (code != 200){
        showDialog(context: context, child: new AlertDialog(content: new Text('Cidade incorreta'),));
    }

    resBody = JSON.decode(response.body);


    List weather = resBody['weather'];
    Map main = resBody['main'];
    Map sys = resBody['sys'];

    print(weather);
    print(main);
    print(sys);

// Dados da imagem retirada do Json
    String s = weather[0].toString();
    List teste = s.split(',');
    String id = teste[3];
    List ids = id.split(':');
    String i = ids[1];
    print(resBody['weather']);
    print(teste[0]);
    String img = i.substring(1,4);
    print(i.length);
    print(img);
    
// Dados da descricao    
    String desc = teste[1];
    List descs = desc.split(':');
    String descI = descs[1];
    weatherClass.description = descI;
    print(descI);

// Dados do map main

    weatherClass.temp = main['temp'];
    weatherClass.temMax = main['temp_max'];
    weatherClass.tempMin = main['temp_min'];
    weatherClass.humidity = main['humidity'];
    weatherClass.city = resBody['name'];
    weatherClass.sunrise = sys['sunrise'];
    weatherClass.sunset = sys['sunset'];

    print(weatherClass.temp);
    print(weatherClass.temMax);
    print(weatherClass.tempMin);
    print(weatherClass.humidity);
    print(weatherClass.city);
    print(weatherClass.sunrise);
    print(weatherClass.sunset);

     u = urlApiImg + img + '.png';

    ste(u);
    print(urlImg);

  }


  void ste(String u){
    setState(() {
      urlImg = u;
    });
  }

    _getToggleChild() {
    if (urlImg == null) {
      return new Text("");
    } else {
      return new  FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image:urlImg);
  }}

  getToggleCity(){
    if (weatherClass.city == null){
      return new Text("");
    }else {
      return new Text(weatherClass.city, style: cityStyle(),);
    }
  }

  getToggleTemp(){
    if (weatherClass.temp == null){
      return new Text("");
    }else {
      return new Text(weatherClass.temp.toString(),textAlign: TextAlign.center,style: cityStyle(),);
    }
  }

  getToggleTempMax(){
    if (weatherClass.temMax == null){
      return new Text("");
    }else {
      return new Text(weatherClass.temMax.toString() + ' MAX',textAlign: TextAlign.center,style: cityStyle(),);
    }
  }

  getToggleTempMin(){
    if (weatherClass.tempMin == null){
      return new Text("");
    }else {
      return new Text(weatherClass.tempMin.toString() + ' MIN',textAlign: TextAlign.center,style: cityStyle(),);
    }
  }

  getToggleDescription(){
    if (weatherClass.description == null){
      return new Text("");
    }else {
      return new Text(weatherClass.description, style: cityStyle());
    }
  }

  getToggleHumidity(){
    if (weatherClass.humidity == null){
      return new Text("");
    }else {
      return new Text(weatherClass.humidity.toString(), style: cityStyle(),textAlign: TextAlign.center,);
    }
  }

  getToggleSunRise(){
    if (weatherClass.sunrise == null){
      return new Text("");
    }else {
      return new Text(getDateRise(weatherClass.sunrise).toString(), style: cityStyle(),);
    }
  }

  getToggleSunSet(){
    if (weatherClass.sunset == null){
      return new Text("");
    }else {
      return new Text(getDateSet(weatherClass.sunset).toString(), style: cityStyle(),);
    }


  }

  TextStyle cityStyle(){
    return new TextStyle(
      color: Colors.white,
      fontSize: 22.9,
    );
  }

  String getDateRise(sec){

    var date = new DateTime.fromMillisecondsSinceEpoch(sec);
    String s = date.toString();
    var r = s.split(" ");
    var t = r[1].substring(0,8);
    print(t);
    return t;

  }

  String getDateSet(sec){

    var date = new DateTime.fromMillisecondsSinceEpoch(sec);
    String s = date.toString();
    var r = s.split(" ");
    var t = r[1].substring(0,8);
    print(t);
    return t;
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.menu), onPressed: ()=> debugPrint("Hey"))
        ],
      ),
      body: new Stack(

        children: <Widget>[

          new Center(
            child:
            new Image.asset("image/umbrella.png",
            fit: BoxFit.fill,
            width: 490.0,
            height: 1000.0,)
          ),

          new Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: new Column(
              // Column is also layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug paint" (press "p" in the console where you ran
              // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
              // window in IntelliJ) to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ new Center(child: getToggleCity()),
              new Center(child: _getToggleChild(),),
              new Center(
                  child: new TextField(onSubmitted: (String inputValue)  {
                    print(inputValue);
                  }, onChanged: (inputValue){
                    setState(() {
                      city = inputValue;
                      print(city);
                    });
                  },
                    decoration: new InputDecoration(hintText: "digite a cidade aqui",hintStyle: cityStyle()),
                    style: cityStyle(),
                  )
              ), new Row(children: <Widget>[ new Expanded(child: getToggleTempMax(),flex: 1,), new Expanded(child: getToggleTemp(),flex: 1,), new Expanded(child: getToggleTempMin(),flex: 1,),],
              ), new Center(child: getToggleDescription()),
              new Row(children: <Widget>[new Container(child: getToggleHumidity(),padding: new EdgeInsets.all(8.0),)],mainAxisAlignment: MainAxisAlignment.center,),
              new Row(children: <Widget>[new Container(child: getToggleSunRise(),padding: new EdgeInsets.all(8.0),)],mainAxisAlignment: MainAxisAlignment.center,),
              new Row(children: <Widget>[new Container(child: getToggleSunSet(),padding: new EdgeInsets.all(8.0),)],mainAxisAlignment: MainAxisAlignment.center,)
              ],
            ),
          ),
        ],

         // This trailing comma makes auto-formatting nicer for build methods.
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed:  getData


      ),
    );


  }
}
