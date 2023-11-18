import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

Future WinProbabilityBottomSheet(BuildContext context){

  Divider divider = const Divider(
    thickness: 0.3,
    color: Color(0xff686c68),
  );
  bool isSwitched = true;
  bool isSwitched2 = true;
  int selectedRadio = 0;
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return showModalBottomSheet(context: context, builder: (BuildContext context){
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return  Container(
          width: width,
          height: height * 0.9,
          decoration: const BoxDecoration(
              color: AppColors.bottomsheetColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))
          ),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff272e36)
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25,right: 25, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Real-time Win Probability",style: TextStyle(color: AppColors.fontColor1,fontSize: 16),),
                  GestureDetector(onTap: (){
                    Navigator.pop(context);
                  },child: const Text("Close",style: TextStyle(color: Color(0xff6eaadd),fontSize: 12),))
                ],),
            ),
            divider,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select a viw of your choice",style: TextStyle(color: AppColors.primary,fontSize: 20,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 15,),
                  Column(
                    children: [
                      Row(children: [
                        Radio(value: 0, groupValue: selectedRadio, onChanged: (val){
                          setState(() {
                            selectedRadio = val as int;
                          });
                        }),
                        const Text("Win Percentage View",style: TextStyle(color: AppColors.primary,fontSize: 18),),
                        const SizedBox(width: 10,),
                        const Icon(Icons.info_outline_rounded,color: Color(0xff888c92),size: 22,)
                      ],),
                      Row(
                        children: [
                          const Expanded(flex: 1,child: SizedBox()),
                          Expanded(flex: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                              width: width * 0.85,
                              height: height * 0.065,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xff888c92),width: 1)
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Column(children: [
                                    Text("Team1",style: TextStyle(color: AppColors.fontColor1),),
                                    Text("__%",style: TextStyle(color: Color(0xff470869)),)
                                  ],),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      height: 5,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                                          color: Color(0xffa74a6e)
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      height: 5,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                                          color: Color(0xff6855b1)
                                      ),
                                    ),
                                  ),
                                  const Column(children: [
                                    Text("Team2",style: TextStyle(color: AppColors.fontColor1)),
                                    Text("__%",style: TextStyle(color: Color(0xff8a3131)))
                                  ],),
                                ],),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Column(
                    children: [
                      Row(children: [
                        Radio(
                            value: 1, groupValue: selectedRadio, onChanged: (val){
                          setState(() {
                            selectedRadio = val as int;
                          });
                        }
                        ),
                        const Text("Number View",style: TextStyle(color: AppColors.primary,fontSize: 18),),
                        const SizedBox(width: 10,),
                        const Icon(Icons.info_outline_rounded,color: Color(0xff888c92),size: 22,)
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Expanded(flex: 2,child: SizedBox(width: 20,)),
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: width * 0.25,
                            height: height * 0.055,
                            decoration: BoxDecoration(
                                color: const Color(0xff88898D),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Center(child: Text("Team",style: TextStyle(color: AppColors.primary,fontSize: 18),),),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 8),

                            width: width * 0.15,
                            height: height * 0.055,
                            decoration: BoxDecoration(
                                color: const Color(0xff005E9B),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Center(child: Text("--",style: TextStyle(color: AppColors.primary,fontSize: 18),),),
                          ),
                          Container(
                            width: width * 0.15,
                            height: height * 0.055,
                            decoration: BoxDecoration(
                                color: const Color(0xffA63F40),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Center(child: Text("--",style: TextStyle(color: AppColors.primary,fontSize: 18),),),
                          ),
                          const Expanded(flex: 3,child: SizedBox(width: 20,)),

                        ],
                      ),

                    ],
                  )
                ],),
            ),
            divider,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Realtime Score Projection",style: TextStyle(color: AppColors.primary,fontSize: 20,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Mid Ov Score Projection",style: TextStyle(fontSize: 14,color: AppColors.fontColor1),),
                      Switch(value: isSwitched, onChanged: (val){
                        setState((){
                          isSwitched = val;
                        });
                      },inactiveThumbColor: AppColors.primary,
                        inactiveTrackColor: AppColors.fontColor1,
                        trackOutlineColor: MaterialStateProperty.all(Colors.transparent),)
                    ],),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    width: width * 0.85,
                    height: height * 0.075,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xff888c92),width: 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("10 Ov Runs",style: TextStyle(color: AppColors.primary),),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: width * 0.15,
                              height: height * 0.055,
                              decoration: BoxDecoration(
                                  color: const Color(0xff005E9B),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(child: Text("NO",style: TextStyle(color: AppColors.primary,fontSize: 18),),),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: width * 0.25,
                              height: height * 0.055,
                              decoration: BoxDecoration(
                                  color: const Color(0xffA63F40),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("YES",style: TextStyle(color: AppColors.primary,fontSize: 18),),
                                  Icon(Icons.arrow_drop_down_outlined,color: Color(0xffFF7575),size: 30,)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ],),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Full Match Score Projection",style: TextStyle(fontSize: 14,color: AppColors.fontColor1),),
                      Switch(value: isSwitched2, onChanged: (val){
                        setState((){
                          isSwitched2 = val;
                        });
                      },inactiveThumbColor: AppColors.primary,
                        inactiveTrackColor: AppColors.fontColor1,
                        trackOutlineColor: MaterialStateProperty.all(Colors.transparent),)
                    ],),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(10),
                    width: width * 0.85,
                    height: height * 0.075,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xff888c92),width: 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("50 Ov Runs",style: TextStyle(color: AppColors.primary),),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: width * 0.15,
                              height: height * 0.055,
                              decoration: BoxDecoration(
                                  color: const Color(0xff005E9B),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(child: Text("NO",style: TextStyle(color: AppColors.primary,fontSize: 18),),),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: width * 0.27,
                              height: height * 0.057,
                              decoration: BoxDecoration(
                                  color: const Color(0xffA63F40),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("YES",style: TextStyle(color: AppColors.primary,fontSize: 15),),
                                  Text(" 38",style: TextStyle(color: AppColors.primary,fontSize: 18),),
                                  Icon(Icons.arrow_drop_down_outlined,color: Color(0xffFF7575),size: 30,)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ],),
                  )
                ],),
            ),

          ],),
        );
      },
    );
  },isScrollControlled: true
  );
}