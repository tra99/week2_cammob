import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../components/dropdown_component.dart';
import '../components/text_field_component.dart';

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
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
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
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  //----------------------------Image Picker-----------------------------
  File? selectedImage;

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
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.arrow_back,
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
            const CustomTextField(labelText: "លេខទូរស័ព្ទផ្ទាល់ខ្លួន",),
            
            const SizedBox(height: 20),
            const CustomTextField(labelText: "ឈ្មោះពេញរបស់អ្នក",),
            
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
                    '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
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
                    contentPadding: EdgeInsets.all(16)
                  ),
                ),
                Positioned(child: Row(
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
                ),)
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
                  contentPadding: EdgeInsets.all(26)
                 ),
                
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: selectedImage !=null? Image.file(selectedImage!):
                      Image.network(
                        "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg",
                      ),
                      ),
                      
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          _pickerImageFromGallery();
                        },
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 32,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "ជ្រើសរើសទីតាំងប្រចាំការ",
              style: TextStyle(fontSize: 20),
            ),
            const Divider(),
            CustomDropdown(
              labelText: "ខេត្ត",
              value: dropdownValue1,
              items: items,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue1 = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomDropdown(
              labelText: "ស្រុក",
              value: dropdownValue2,
              items: items,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue2 = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomDropdown(
              labelText: "ឃុំ",
              value: dropdownValue3,
              items: items,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue3 = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomDropdown(
              labelText: "ភូមិ",
              value: dropdownValue4,
              items: items,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue4 = newValue;
                });
              },
            ),
            const SizedBox(height: 30),
            const Text("បង្កើតលេខសម្ងាត់",style: TextStyle(fontSize: 20),),
            const Divider(),
            const SizedBox(height: 20),
            const CustomTextField(labelText: "លេខសម្ងាត់",),
            const SizedBox(height: 20),
            const CustomTextField(labelText: "បញ្ជាក់លេខសម្ងាត់",),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "បន្ទាប់",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //-------------------------Image Picker----------------------------
  Future _pickerImageFromGallery()async{
    final returnImage= await ImagePicker().pickImage(source: ImageSource.gallery);

    if(returnImage==null) return;
    setState(() {
      selectedImage=File(returnImage.path);
    });
  }
}
