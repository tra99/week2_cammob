import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test_week2/models/register_data/communce_model.dart';
import 'package:test_week2/models/register_data/register_model.dart';
import 'package:test_week2/providers/response_data_provider.dart';
import '../components/dropdown_component.dart';
import '../components/text_field_component.dart';
import '../models/register_data/district_model.dart';
import '../models/register_data/province_model.dart';
import '../models/register_data/village_model.dart';
import '../validations/validation.dart';
import 'waiting/pending_screen.dart';

class RegisterScreen extends StatefulWidget {
  final String? restorationId;
  const RegisterScreen({super.key, this.restorationId});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum SingingCharacter { female, male }

class _RegisterScreenState extends State<RegisterScreen> with RestorationMixin {
  SingingCharacter? _character = SingingCharacter.female;

  //----------------drop down--------------------------
  String? dropdownValue1;
  String? dropdownValue2;
  String? dropdownValue3;
  String? dropdownValue4;

  final List<String> items = ['Option 1', 'Option 2', 'Option 3'];
  List<String> selectedItems = [];

  //----------------------date picker----------------------------------
  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture;

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  @override
  void initState() {
    super.initState();
    _restorableDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
      onComplete: _selectDate,
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(
          _datePickerRoute,
          arguments: _selectedDate.value.millisecondsSinceEpoch,
        );
      },
    );
  }

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    DateTime initialDate = DateTime.now();

    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: initialDate,
          firstDate: DateTime(initialDate.year - 50, 1, 1),
          lastDate: DateTime(initialDate.year + 10, 12, 31),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.year}/${_selectedDate.value.month}/${_selectedDate.value.day}'),
        ));
      });
    }
  }

  //-----------Convert Image to base64-----------------------
  File? selectedImage;
  String base64String = '';

  Future _pickerImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
    });

    await imageToBase64(File(returnImage.path));
  }

  Future<void> imageToBase64(File imageFile) async {
    Uint8List bytes = await imageFile.readAsBytes();
    String base64String = base64.encode(bytes);

    setState(() {
      this.base64String = base64String;
    });
  }

  //----------------------Dropdown Change Handling----------------------
  List<District> filteredDistricts = [];
  List<Commune> filteredCommunes = [];
  List<Village> filteredVillages = [];

  void _onDropdownChanged(String? newValue, String type) {
    setState(() {
      if (type == 'province') {
        dropdownValue1 = newValue;
        dropdownValue2 = null;
        dropdownValue3 = null;
        dropdownValue4 = null;
        filteredDistricts =
            context.read<ResponseProvider>().getDistrictsByProvince(newValue!);
        filteredCommunes = [];
        filteredVillages = [];
      } else if (type == 'district') {
        dropdownValue2 = newValue;
        dropdownValue3 = null;
        dropdownValue4 = null;
        filteredCommunes =
            context.read<ResponseProvider>().getCommunesByDistrict(newValue!);
        filteredVillages = [];
      } else if (type == 'commune') {
        dropdownValue3 = newValue;
        dropdownValue4 = null;
        filteredVillages =
            context.read<ResponseProvider>().getVillagesByCommune(newValue!);
      } else if (type == 'village') {
        dropdownValue4 = newValue;
      }
    });
  }

  //----------------Register------------------------
  void _register() async {
    if (formKey.currentState!.validate()) {
      final registrationData = RegisterModel(
        phoneNumber: phoneController.text,
        fullName: usernameController.text,
        birthday: _selectedDate.value,
        gender: _character == SingingCharacter.female ? 'Female' : 'Male',
        provinceId: context.read<ResponseProvider>().provinces.firstWhere((p) => p.nameKh == dropdownValue1).id,
        districtId: filteredDistricts.firstWhere((d) => d.nameKh == dropdownValue2).id,
        communeId: filteredCommunes.firstWhere((c) => c.nameKh == dropdownValue3).id,
        villageId: filteredVillages.firstWhere((v) => v.nameKh == dropdownValue4).id,
        password: passwordController.text,
        nidFile: 'data:image/png;base64,$base64String',
      );

      final response = await context.read<ResponseProvider>().register(registrationData);

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration successful')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PendingScreen(phoneNumber: phoneController.text),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed: ${response['message']}')));
      }
    }
  }

  Future<void> _pickerImageFromCamera() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
    });
    await imageToBase64(File(returnImage.path));
  }

  Future<void> _pickerImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickerImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickerImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "បង្កើតគណនី",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const Text("បំពេញព័ត៏មានរបស់អ្នក", style: TextStyle(fontSize: 20)),
            const Divider(),
            const SizedBox(height: 10),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: phoneController,
                    labelText: "លេខទូរស័ព្ទផ្ទាល់ខ្លួន",
                    keyboardType: TextInputType.phone,
                    validator: validatePhoneNumber,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: usernameController,
                    labelText: "ឈ្មោះពេញរបស់អ្នក",
                    validator: validateNotEmpty,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    readOnly: true,
                    onTap: () {
                      _restorableDatePickerRouteFuture.present();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "ថ្ងៃខែ​ ឆ្នាំកំណើត",
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    controller: TextEditingController(
                      text:
                          '${_selectedDate.value.year}/${_selectedDate.value.month}/${_selectedDate.value.day}',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "ភេទ",
                            border: OutlineInputBorder(),
                            enabled: false,
                            contentPadding: EdgeInsets.all(16)),
                      ),
                      Positioned(
                        child: Row(
                          children: [
                            Expanded(
                              child: RadioListTile<SingingCharacter>(
                                title: const Text('ស្រី'),
                                activeColor: Colors.blue,
                                value: SingingCharacter.female,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<SingingCharacter>(
                                title: const Text('បុរស'),
                                activeColor: Colors.blue,
                                value: SingingCharacter.male,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "រូបថតរបស់អ្នក",
                            border: OutlineInputBorder(),
                            enabled: false,
                            contentPadding: EdgeInsets.all(26)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: selectedImage != null
                                  ? Image.file(selectedImage!)
                                  : Image.network(
                                      "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg",
                                    ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: _pickerImage,
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "ជ្រើសរើសទីតាំងប្រចាំការ",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Divider(),
                  Consumer<ResponseProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (value.errorMessage.isNotEmpty) {
                        return Center(
                            child: Text("Error: ${value.errorMessage}"));
                      } else if (value.provinces.isEmpty) {
                        return const Center(
                            child: Text("Data is not available"));
                      } else {
                        List<Province> provinces = value.provinces;

                        return Column(
                          children: [
                            CustomDropdown(
                              labelText: "ខេត្ត",
                              value: dropdownValue1,
                              items: provinces
                                  .map((province) => province.nameKh)
                                  .toList(),
                              onChanged: (String? newValue) {
                                _onDropdownChanged(newValue, 'province');
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomDropdown(
                              labelText: "ស្រុក",
                              value: dropdownValue2,
                              items: filteredDistricts
                                  .map((district) => district.nameKh)
                                  .toList(),
                              onChanged: (String? newValue) {
                                _onDropdownChanged(newValue, 'district');
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomDropdown(
                              labelText: "ឃុំ",
                              value: dropdownValue3,
                              items: filteredCommunes
                                  .map((commune) => commune.nameKh)
                                  .toList(),
                              onChanged: (String? newValue) {
                                _onDropdownChanged(newValue, 'commune');
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomDropdown(
                              labelText: "ភូមិ",
                              value: dropdownValue4,
                              items: filteredVillages
                                  .map((village) => village.nameKh)
                                  .toList(),
                              onChanged: (String? newValue) {
                                _onDropdownChanged(newValue, 'village');
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "បង្កើតលេខសម្ងាត់",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    isPasswordField: true,
                    labelText: "លេខសម្ងាត់",
                    keyboardType: TextInputType.visiblePassword,
                    validator: validatePassword,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: confirmPasswordController,
                    labelText: "បញ្ជាក់លេខសម្ងាត់",
                    keyboardType: TextInputType.visiblePassword,
                    isPasswordField: true,
                    validator: (value) =>
                        validateConfirmPassword(value, passwordController.text),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _register();
                        }
                      },
                      child: const Text(
                        "បន្ទាប់",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
