import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mvvm_practice_app/res/app_url.dart';
import 'package:mvvm_practice_app/res/my_app_colors.dart';
import 'package:mvvm_practice_app/view_model/all_pets_petsmarket_post_view_model.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class PetsRegistration extends StatefulWidget {
  const PetsRegistration({super.key});

  @override
  State<PetsRegistration> createState() => _PetsRegistrationState();
}

class _PetsRegistrationState extends State<PetsRegistration> {
  // pets post api view model object
  AllPetsMarketPostPetViewModel allPetsMarketPostPetViewModel =
      AllPetsMarketPostPetViewModel();

  bool isPdfUploaded = false; // to check weather file is uploaded or not
  bool isBookTitlePageSelected =
      false; // to check weather book Title is uploaded  or not
  String fileName = '';
  String bookTitlePageImagePath = '';

  String title = "";
  String description = "";

  // Controllers

  var petsNameController = TextEditingController();
  var petsPriceController = TextEditingController();
  var petAvailibleController = TextEditingController();
  var petDiscriptioncontroller = TextEditingController();

  // drop down list
  var Avalability = [
    'Is Your pet available for selling',
    'Yes',
    'No',
  ];

  // variables for conditions down in dropdown conditions
  // String selectedMotivatinalBookType = '';
  // String selectedMotivatinalBookLanguage = '';
  String selectedAvalability = '';
  // String selectedIslamicBookType = '';
  // String selectedIslamicBookLanguage = '';
  // var finalSelectedBookType = '';
  // var finalSelectedBookLanguage = '';

// for post api image picking and sending using post api

  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  @override
  void initState() {
    selectedAvalability = Avalability[0];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allPetsMarketPostPetViewModel =
        Provider.of<AllPetsMarketPostPetViewModel>(context);

    return ModalProgressHUD(
      inAsyncCall: allPetsMarketPostPetViewModel.loading,
      child: Scaffold(
          backgroundColor: MyColors.KWhite,
          appBar: AppBar(
            title: Text(
              "Sell Your pet ",
              style: TextStyle(color: MyColors.KWhite),
            ),
            backgroundColor: MyColors.kPrimary,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/bg_bg.png'),
            //     alignment: Alignment.topCenter,
            //     fit: BoxFit.fill,
            //   ),
            // ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Book title Container
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: MyColors.kSecondary,
                        // border: Border.all(color: Colors.grey)
                      ),
                      padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: TextFormField(
                        controller: petsNameController,
                        decoration: InputDecoration(
                            labelText: 'Enter Pet\'s Name',
                            border: InputBorder.none),
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter name of your pet!';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Price Container
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: MyColors.kSecondary,
                        // border: Border.all(color: Colors.grey)
                      ),
                      padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: TextFormField(
                        controller: petsPriceController,
                        decoration: InputDecoration(
                            labelText: 'Enter Price', border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter price for you pet!';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Dropdown for selecting Book Catagory
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                          color: MyColors.kSecondary,
                          // border: Border.all(color: Colors.grey)
                        ),
                        height: 75,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                              //elevation: 30,
                              //alignment: AlignmentDirectional.center,
                              //elevation: 80,
                              isDense: true,
                              iconSize: 40,
                              isExpanded: true,
                              dropdownColor: MyColors.kSecondary,
                              style: TextStyle(
                                color: MyColors.kBlack,
                              ),
                              value: selectedAvalability,
                              items: Avalability.map((String itemss) {
                                return DropdownMenuItem(
                                  value: itemss,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(16, 16, 8, 8),
                                    child: Text(itemss),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedAvalability = newValue!;
                                });
                              }),
                        )),

                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    //Discription Field
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: MyColors.kSecondary,
                        // border: Border.all(color: Colors.grey)
                      ),
                      padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: TextFormField(
                        controller: petDiscriptioncontroller,
                        textAlign: TextAlign.start,
                        maxLength: 430,
                        maxLines: 5,
                        decoration: InputDecoration(
                            labelText: 'Enter Description',
                            border: InputBorder.none),
                        keyboardType: TextInputType.text,
                        //obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Description!';
                          }
                        },
                        onFieldSubmitted: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                      ),
                    ),

                    ///////////////////////////////////////////

                    SizedBox(
                      height: 20,
                    ),

                    // Container That shows file upload button

                    // Container That shows image is slected or not
                    isPdfUploaded
                        ? Container(
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(29),
                              color: MyColors.kSecondary,
                              // border: Border.all(color: Colors.grey)
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text('Selected file : ${fileName}'),
                              ),
                            ),
                          )
                        : Container(),

                    /////////////////////////

                    SizedBox(
                      height: 20,
                    ),

                    // Container That shows image upload button
                    InkWell(
                      //splashColor: Colors.red,
                      onTap: () async {
                        getImage();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                          color: MyColors.kPrimary,
                          // border: Border.all(color: Colors.grey)
                        ),
                        child: Center(
                          child: Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Text container
                                  Container(
                                    child: Center(
                                      child: Text(
                                        'Select Pet\'s Picture',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // Icon container
                                  Container(
                                    child: Center(
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    // show image which is slelected
                    image != null
                        ? Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: MyColors.kSecondary,
                              // border: Border.all(color: Colors.grey)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.file(
                                File(image!.path).absolute,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(),
                    /////////
                    ///
                    SizedBox(
                      height: 20,
                    ),

                    // Upload button
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: MyColors.kPrimary,
                          border: Border.all(color: Colors.white)
                          // border: Border.all(color: Colors.grey)
                          ),
                      child: TextButton(
                          onPressed: () async {
                            Map<String, String> data = {
                              'pet_name': "Donkey",
                              'pet_status': "1",
                              'pet_description':
                                  "Best Choise for you to buy this cat, cute cate, good cat, Alpha, Beta and Gemma.",
                              'pet_price': "66666"
                            };

                            // allPetsMarketPostPetViewModel
                            //     .getPetMarketPostResultFromApi(data);

                            //uploadImage();
                            // progressDialog.dismiss();

                            allPetsMarketPostPetViewModel
                                .getPetMarketPostResultFromApi(
                              data,
                              image,
                              context,
                            );
                          },
                          child: Text(
                            'Post',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

// Select Title page for book
  // File? pickedImage;
  // Future selectPetsPicture() async {
  //   final result = await FilePicker.platform.pickFiles(type: FileType.image);
  //   //var alpha = result!.paths;

  //   // print(
  //   //     '////////////////////////////////////////================= ${result!.paths}');

  //   if (result == null) return;
  //   setState(() {
  //     //pickedImage = File(result.paths);
  //     bookTitlePageImagePath = result.files.first.path.toString();
  //     print(
  //         '////////////////////////////////////////================= $bookTitlePageImagePath');
  //     isBookTitlePageSelected = true;
  //   });
  // }

// Open Selected Image File

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      //print(image!.path);
      setState(() {});
    } else {
      print('no image selected');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    // print('Hello i am before byte stram');
    var stream = new http.ByteStream(image!.openRead());

    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://kawiishapps.com/api/postpets');

    var request = new http.MultipartRequest('POST', uri);

    // request.fields['pet_name'] = "Beta";
    // request.fields['pet_status'] = "5";
    // request.fields['pet_description'] = "123";
    // request.fields['pet_price'] = "888";

    // var multiport = new http.MultipartFile('file', stream, length);

    // request.files.add(multiport);

    Map<String, String> data = {
      'pet_name': "Bilee",
      'pet_status': "2",
      'pet_description':
          "Best Choise for you to buy this cat, cute cate, good cat, Alpha, Beta and Gemma.",
      'pet_price': "5555"
    };

    request.fields.addAll(data
        //   {
        //   'pet_name': "Cow",
        //   'pet_status': "1",
        //   'pet_description':
        //       "Best Choise for you to buy this cat, cute cate, good cat, Alpha, Beta and Gemma.",
        //   'pet_price': "444"
        // }
        );

    request.files
        .add(await http.MultipartFile.fromPath('file', '${image!.path}'));

    var response = await request.send();
    print('Hello i am after Multipart Request');

//=================================

//=====================================

    print(response.stream.toString());
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('image uploaded');
    } else {
      print('failed');
      print("My Status Code : ${response.statusCode}");
      setState(() {
        showSpinner = false;
      });
    }
  }

// submit post Url
  void _submit() {}

  // for picking PDf file

  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   // type: FileType.custom, allowedExtensions: ['pdf']
  //   //var alpha = result!.paths;

  //   if (result == null) return;
  //   setState(() {
  //     pickedPdfFile = File(result.files.first.path.toString());
  //     print(
  //         '//////////////////////////////////////// ================= $pickedPdfFile');
  //     fileName = result.paths[0]!.split('/').last.toString();
  //     isPdfUploaded = true;
  //   });
  // }
}