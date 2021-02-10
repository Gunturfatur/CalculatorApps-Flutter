import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KalkulatorMain(),
    );
  }
}
class KalkulatorMain extends StatefulWidget {
  @override
  IsiKalkulator createState() => IsiKalkulator();
}

class IsiKalkulator extends State<KalkulatorMain> {
  dynamic displaytxt = 20;
  Widget tombol(String btntxt,Color btncolor,Color txtcolor){
    return  Container(
      child: RaisedButton(
        onPressed: (){
        perhitungan(btntxt);
        }, 
        child: Text('$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('KalkulatorKU'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //! Tampilan
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('$text',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                onPressed: (){
                perhitungan('C');
                },
                shape: StadiumBorder(),
                child: Text('C',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.red),
                ),
                color: Colors.grey[850],
                ),
                tombol('+/-',Colors.grey[850],Colors.lightGreen),
                tombol('/',Colors.grey[850],Colors.lightGreen),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                tombol('7',Colors.grey[850],Colors.white),
                tombol('8',Colors.grey[850],Colors.white),
                tombol('9',Colors.grey[850],Colors.white),
                tombol('x',Colors.grey[850],Colors.lightGreen),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                tombol('4',Colors.grey[850],Colors.white),
                tombol('5',Colors.grey[850],Colors.white),
                tombol('6',Colors.grey[850],Colors.white),
                tombol('-',Colors.grey[850],Colors.lightGreen),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                tombol('1',Colors.grey[850],Colors.white),
                tombol('2',Colors.grey[850],Colors.white),
                tombol('3',Colors.grey[850],Colors.white),
                tombol('+',Colors.grey[850],Colors.lightGreen),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //this is button Zero
                RaisedButton(
                padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                onPressed: (){
                perhitungan('0');
                },
                shape: StadiumBorder(),
                child: Text('0',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white),
                ),
                color: Colors.grey[850],
                ),
                tombol('.',Colors.grey[850],Colors.white),
                tombol('=',Colors.lightGreen,Colors.white),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  //! Logika Perhitungan
  dynamic text ='0';
  double nilaiSatu = 0;
  double nilaiDua = 0;

  dynamic hitung = '';
  dynamic hasil = '';
  dynamic opratorMTK = '';
  dynamic preOpr = '';
   void perhitungan(btnText) {


    if(btnText  == 'C') {
      text ='0';
      nilaiSatu = 0;
      nilaiDua = 0;
      hitung = '';
      hasil = '0';
      opratorMTK = '';
      preOpr = '';
    //! Proses Hitung
    } else if( opratorMTK == '=' && btnText == '=') {

      if(preOpr == '+') {
         hasil = add();
      } else if( preOpr == '-') {
          hasil = sub();
      } else if( preOpr == 'x') {
          hasil = mul();
      } else if( preOpr == '/') {
          hasil = div();
      } 

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(nilaiSatu == 0) {
          nilaiSatu = double.parse(hitung);
      } else {
          nilaiDua = double.parse(hitung);
      }

      if(opratorMTK == '+') {
          hasil = add();
      } else if( opratorMTK == '-') {
          hasil = sub();
      } else if( opratorMTK == 'x') {
          hasil = mul();
      } else if( opratorMTK == '/') {
          hasil = div();
      } 
      preOpr = opratorMTK;
      opratorMTK = btnText;
      hitung = '';
    }
    
    else if(btnText == '+/-') {
        hitung.toString().startsWith('-') ? hitung = hitung.toString().substring(1): hitung = '-'+hitung.toString();        
        hasil = hitung;        
    
    } 
    
    else {
        hitung = hitung + btnText;
        hasil = hitung;        
    }


    setState(() {
          text = hasil;
        });

  }

  //! Fungsi - fungsi Perhitungan
  String add() {
         hitung = (nilaiSatu + nilaiDua).toString();
         nilaiSatu = double.parse(hitung);           
         return doesContainDecimal(hitung);
  }

  String sub() {
         hitung = (nilaiSatu - nilaiDua).toString();
         nilaiSatu = double.parse(hitung);
         return doesContainDecimal(hitung);
  }
  String mul() {
         hitung = (nilaiSatu * nilaiDua).toString();
         nilaiSatu = double.parse(hitung);
         return doesContainDecimal(hitung);
  }
  String div() {
          hitung = (nilaiSatu / nilaiDua).toString();
          nilaiSatu = double.parse(hitung);
          return doesContainDecimal(hitung);
  }

  //! Fungsi Desimal
  String doesContainDecimal(dynamic hitung) {
    
    if(hitung.toString().contains('.')) {
        List<String> splitDecimal = hitung.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return hitung = splitDecimal[0].toString();
    }
    return hitung; 
  }

}
