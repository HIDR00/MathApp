
import 'package:flutter/material.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:provider/provider.dart';

import '../configs/style_configs.dart';

class FlipWidget extends StatefulWidget {
  const FlipWidget({super.key,required this.A,required this.B,required this.answer,required this.flip});
  final int A,B,answer;
  final bool flip;

  @override
  State<FlipWidget> createState() => _FlipWidgetState();
}

class _FlipWidgetState extends State<FlipWidget> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PhepTinh>().Controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,);
    animation = Tween<double>(begin: 0,end: 2).animate(context.read<PhepTinh>().controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform(
        transform: Matrix4.identity()
        ..rotateY(animation.value * 3.141),
        alignment: Alignment.center,
        child: child,
        ),
      child: GestureDetector(
        onTap: (){
        },
        child: Container(
                    height: 120,
                    width: 380,
                    decoration: BoxDecoration(
                      color: widget.flip ? True : BGYellow,
                      borderRadius:BorderRadius.circular(10)
                    ),
                    child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(left: 125),                              
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Icon(Icons.star,color: Color(0xFFD9D9D9));
                                },
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${widget.A} ${context.read<PhepTinh>().phepTinh ? "x" : ":"} ${widget.B} = ",style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),
                                  ),
                                  context.read<PhepTinh>().typeAnswer ?
                                  widget.flip ? Text("${widget.answer}",style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)) : 
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color:  Colors.white,
                                      border: Border.all(
                                        color: stroke,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Center(child: Text("?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: stroke),)),
                                  ) : 
                                  Selector<PhepTinh,String>(
                                    selector: (ctx, state) => state.answerDisplay,
                                    builder: (context, value, _) {
                                      return Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color:  Colors.white,
                                        border: Border.all(
                                          color: stroke,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      child: Center(child: Text("${value}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: stroke),)),
                                    );
                                    } ,
                                  )
                                ],
                              )
                            ),
                          ],
                        ),
                  ),
      ),
    );
  }
}