import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

Future AppThemeBottomSheet(BuildContext context){
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  bool isSwitched = true;
  bool isRadioButtonSelected = false;
  int selectedRadio = 0;
  String selectedImage = 'lib/assets/images/darktheme.jpg';
  Color selectedColor = AppColors.bottomsheetColor;
  Color selectedTextColor = AppColors.primary;
  const divider = Divider(
    thickness: 0.3,
    color: Color(0xff686c68),
  );

  const String darkThemeImage = 'lib/assets/images/darktheme.jpg';
  const String lightThemeImage = 'lib/assets/images/lighttheme.jpg';

  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context){

        return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
          return Container(
            width: width,
            height: height * 0.7,
            decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: width * 0.65,
                  height: height * 0.35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(selectedImage,fit: BoxFit.fill,) //want to change this image to this "lib/assets/images/lighttheme.jpg"

                  )),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: width * 0.5,
                child: AbsorbPointer(
                  absorbing: !isRadioButtonSelected,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Dark",style: TextStyle(color: selectedTextColor),),
                          Radio(
                              value: 0 , groupValue: selectedRadio, onChanged: (val){
                            setState((){
                              selectedRadio = val as int;
                              selectedImage = darkThemeImage;
                              selectedColor = AppColors.bottomsheetColor;
                              selectedTextColor = AppColors.primary;
                            });
                          }),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Light",style: TextStyle(color: selectedTextColor)),
                          Radio(value: 1 , groupValue: selectedRadio, onChanged: (val){
                            setState((){
                              selectedRadio = val as int;
                              selectedImage = lightThemeImage;
                              selectedColor = AppColors.primary;
                              selectedTextColor = AppColors.secondary;
                            });
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              divider,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                child:  Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Use device settings",style: TextStyle(color: selectedTextColor,fontSize: 15)),
                          const Text("Your phone theme",style: TextStyle(color: AppColors.fontColor1,fontSize: 10,fontWeight: FontWeight.w300))
                        ],),
                      Transform.scale(
                        scale: 1,
                        child: Switch(
                          value: isSwitched, onChanged: (val){
                          setState((){
                            isSwitched = val;
                            isRadioButtonSelected = !val;
                          });
                        },
                          trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                          activeTrackColor: const Color(0xff09426f),
                          inactiveTrackColor: const Color(0xff1e272e),
                          inactiveThumbColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: width,
                      height: 50,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: const Color(0xff09426f),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(child: Text("Save Changes",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),)),
                    ),
                  )
                ],),
              )
            ],),
          );
        });
      });
}