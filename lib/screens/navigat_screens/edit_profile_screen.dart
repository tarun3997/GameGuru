import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({required this.photoURL, required this.email, required this.displayName,required this.onDisplayNameChanged, Key? key}) : super(key: key);
  final String photoURL;
  final String email;
  final String displayName;
  final Function(String) onDisplayNameChanged;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}


class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  String _newDisplayName = "";
  bool _isButtonEnabled = false;


  void _saveChanged(){
    if (_formKey.currentState!.saveAndValidate()){
      final formData = _formKey.currentState!.value;
      final newName = formData['name'] as String;

      if(newName != widget.displayName){
        setState(() {
          _newDisplayName = newName;
          _isButtonEnabled = true;
          saveDisplayNameToPrefs(newName);

        });
      }else{
        setState(() {
          _isButtonEnabled = false;
        });
      }
    }

  }
  Future<void> saveDisplayNameToPrefs(String newName) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('displayName', newName);
  }

  Divider divider = const Divider(
    thickness: 0.3,
    color: Color(0xff686c68),
  );
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.fontColor2,
                  size: 28,
                )),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Edit Profile",
              style: TextStyle(color: AppColors.fontColor2, fontSize: 18),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          divider,
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff333433), // Set the border color here
                width: 1,
              ),
            ),
            child: CircleAvatar(
              foregroundColor: const Color(0xff333433),
              backgroundColor: const Color(0xff1a1818),
              radius: 55,
              backgroundImage: CachedNetworkImageProvider(widget.photoURL),
            ),
          ),
          Expanded(
            flex: 8,
            child: FormBuilder(
              key: _formKey,
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(color: AppColors.fontColor1, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FormBuilderTextField(
                      name: 'name',
                      cursorColor: Colors.red,
                      style: const TextStyle(color: AppColors.primary),
                      initialValue: widget.displayName,
                      onChanged: (value){
                        _newDisplayName = value!;
                        _isButtonEnabled = value != widget.displayName;
                      },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.fontColor1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusColor: AppColors.fontColor1,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.fontColor1),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(color: AppColors.fontColor1, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.fontColor1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(widget.email,
                      style: const TextStyle(
                        color: Color(0xff656569,),
                        fontSize: 16
                      ),),
                          )),
                    ),

                  ],
                ),
              ),
            )),
          ),
          GestureDetector(onTap: (){
            _saveChanged();
          },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _isButtonEnabled ? const Color(0xff09426f) : const Color(0xff171c22)
              ),
              child: const Center(child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),)),
            ),
          ),
          const Expanded(child: SizedBox())

        ],
      ),
    );
  }
}
