import 'package:flutter/material.dart';
import 'package:math/model/number_model.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:provider/provider.dart';

import '../configs/style_configs.dart';

class BangTinh extends StatefulWidget {
  const BangTinh({super.key,required this.phepTinh});
  final bool phepTinh;

  @override
  State<BangTinh> createState() => _BangTinhState();
}

class _BangTinhState extends State<BangTinh> {
  int A = 0;
  List<NumberModel> lNumber = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.phepTinh == false){
      A = 1;
    }
    lNumber = context.read<PhepTinh>().lNumber;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            )
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Bảng tính",
              style: TextStyle(
                color: Colors.black
              ),
            ),
            centerTitle: true,
            backgroundColor: BG,
            shadowColor: Shadow,
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: stroke
                  ),
                  color: Yellow2,
                  shape: BoxShape.circle
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: stroke,
                ),
              ),
            ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5,top: 30),
              child: Container(
                height: 450,
                width: 380,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow:[
                        BoxShadow(color: Color(0xFFE7D7BE),offset: Offset(0, 5))
                      ],
                ),
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, crossAxisSpacing: 5,mainAxisSpacing: 5,mainAxisExtent: 180
                  ), 
                  itemBuilder: (context,index){
                    
                      return GestureDetector(
                        onTap: () {
                         print("Star: ${context.read<PhepTinh>().phepTinh ? context.read<PhepTinh>().lNumber[24*A+index*2].numberStar : context.read<PhepTinh>().lNumber[24*A+index*2+1].numberStar}");
                        },
                        child: Container(
                          child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(left: 30,bottom: 10),                              
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index2) {
                                  return widget.phepTinh ? context.read<PhepTinh>().lNumber[24*A+index*2].numberStar <= index2 ? Icon(Icons.star,color: Color(0xFFD9D9D9)) : Icon(Icons.star,color: Color(0xFFeeab04)) : context.read<PhepTinh>().lNumber[24*A+index*2+1].numberStar <= index2 ? Icon(Icons.star,color: Color(0xFFD9D9D9)) : Icon(Icons.star,color: Color(0xFFeeab04));
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: widget.phepTinh ? Text("${lNumber[24*A+index*2].A} x ${lNumber[24*A+index*2].B}= ${lNumber[24*A+index*2].answer}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),) : 
                              Text("${lNumber[24*A+index*2+1].A} : ${lNumber[24*A+index*2+1].B} = ${lNumber[24*A+index*2+1].answer}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                              ),
                          ],
                                            ),
                        ),
                      );
                  }
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 100,left: 20,right: 20),
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, crossAxisSpacing: 10,mainAxisSpacing: 20
                  ), 
                  itemBuilder: (context,index){
                    if(widget.phepTinh == false && index == 0){
                      return Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color:Colors.white,
                          border: Border.all(
                            color: stroke,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      );
                    }else{
                      return GestureDetector(
                      onTap: (){
                        setState(() {
                          A=index;
                        });
                      },
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: index == A ? Yellow2 : Colors.white,
                          border: Border.all(
                            color: stroke,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Center(child: Text("${index}",style: TextStyle(fontSize: 20),)),
                      ),
                    );
                    }
                  }
                ),
              ),
            )
          ],
        ),
      ),
      ],
    );
  }
}