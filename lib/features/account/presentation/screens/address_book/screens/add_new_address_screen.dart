import 'package:ecommerce_app/core/alerts/alert.dart';
import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_app/features/account/presentation/blocs/address/bloc/address_bloc.dart';
import 'package:ecommerce_app/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:toastification/toastification.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({
    super.key,
    required this.id,
    this.country = '',
    this.state = '',
    this.fullName = '',
    this.buildingNo = '',
    this.landMark = '',
    this.area = '',
    this.town = '',
    this.mobileNo = '',
    this.pincode = '',
    this.isDefault,
  });

  final String? country,
      id,
      state,
      fullName,
      buildingNo,
      landMark,
      area,
      town,
      mobileNo,
      pincode;
  final bool? isDefault;
  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  late TextEditingController fullNameController;
  late TextEditingController mobileNumberController;
  late TextEditingController pincodeController;
  late TextEditingController landMarkController;
  late TextEditingController buldingNoController;
  late TextEditingController townController;
  late TextEditingController areaController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? country;
  String? state;
  late ValueNotifier<bool> isDefault;
  @override
  void initState() {
    super.initState();

    state = widget.state;
    country = widget.country;

    if ((country?.isEmpty ?? true) || (state?.isEmpty ?? true)) {
      getUserLocationText();
    }

    fullNameController = TextEditingController(text: widget.fullName ?? '');
    mobileNumberController = TextEditingController(text: widget.mobileNo ?? '');
    pincodeController = TextEditingController(text: widget.pincode ?? '');
    landMarkController = TextEditingController(text: widget.landMark ?? '');
    buldingNoController = TextEditingController(text: widget.buildingNo ?? '');
    townController = TextEditingController(text: widget.town ?? '');
    areaController = TextEditingController(text: widget.area ?? '');

    isDefault = ValueNotifier(widget.isDefault ?? false);
  }

  Future<void> getUserLocationText() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position pos = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      pos.latitude,
      pos.longitude,
    );

    if (placemarks.isNotEmpty && mounted) {
      setState(() {
        country = placemarks.first.country;
        state = placemarks.first.administrativeArea;
      });
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    fullNameController.dispose();
    mobileNumberController.dispose();
    pincodeController.dispose();
    landMarkController.dispose();
    buldingNoController.dispose();
    townController.dispose();
    areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            AppBarWidget(
              title: 'Add Address',
              onPressed: () {},
              isBottom: false,
              needAction: false,
            ),
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Country",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: country,
                      isDense: true,
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      items: country != null
                          ? [
                              DropdownMenuItem(
                                value: country,
                                child: Text(country!),
                              ),
                            ]
                          : [],
                      onChanged: (value) {
                        setState(() => country = value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Fields
                    buildTextField(
                      label: "Full Name",
                      hint: "Enter your full name",
                      controller: fullNameController,
                      inputType: TextInputType.name,
                    ),
                    buildTextField(
                      label: "Mobile Number",
                      hint: "Enter your mobile number",
                      controller: mobileNumberController,
                      inputType: TextInputType.phone,
                      helper: "May be used to assist delivery",
                    ),
                    buildTextField(
                      label: "Flat,House no.,Building,Company,Apartment",
                      hint: "",
                      controller: buldingNoController,
                      inputType: TextInputType.number,
                    ),
                    buildTextField(
                      label: "Area,Colony,Sector,Village",
                      hint: "",
                      controller: areaController,
                      inputType: TextInputType.number,
                    ),
                    buildTextField(
                      label: "LandMark",
                      hint: "E.g. near school, hospital etc.",
                      controller: landMarkController,
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: buildTextField(
                            label: "Town/City",
                            hint: "",
                            controller: townController,
                            inputType: TextInputType.number,
                          ),
                        ),
                        Expanded(
                          child: buildTextField(
                            label: "Pincode",
                            hint: "6 digit [0-9] PIN code",
                            controller: pincodeController,
                            inputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    DropdownButtonFormField<String>(
                      value: state,
                      isDense: true,
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      items: state != null
                          ? [
                              DropdownMenuItem(
                                value: state,
                                child: Text(state!),
                              ),
                            ]
                          : [],
                      onChanged: (value) {
                        setState(() => state = value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: isDefault,
                          builder: (context, value, child) {
                            return Checkbox(
                              value: isDefault.value,
                              onChanged: (newValue) {
                                isDefault.value = newValue ?? false;
                              },
                            );
                          },
                        ),
                        Text('Make this my default address'),
                      ],
                    ),
                    k10H,

                    /// Button
                    RoundedButton(
                      title: widget.id == null || widget.id!.isEmpty
                          ? 'Add Address'
                          : 'Update Address',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.id == null || widget.id!.isEmpty) {
                            context.read<AddressBloc>().add(
                              AddAddressEvent(
                                isDefault: isDefault.value,
                                country: country ?? '',
                                buildingNo: buldingNoController.text.trim(),
                                fullName: fullNameController.text.trim(),
                                landMark: landMarkController.text.trim(),
                                area: areaController.text.trim(),
                                town: townController.text.trim(),
                                state: state!,
                                mobileNo: mobileNumberController.text.trim(),
                                pincode: pincodeController.text.trim(),
                              ),
                            );
                            alert(
                              'Address Added',
                              'Address Added Successfully',
                              ToastificationType.success,
                            );
                          } else {
                            context.read<AddressBloc>().add(
                              UpdateAddressEvent(
                                id: widget.id ?? '',
                                isDefault: isDefault.value,
                                country: country ?? '',
                                buildingNo: buldingNoController.text.trim(),
                                fullName: fullNameController.text.trim(),
                                landMark: landMarkController.text.trim(),
                                area: areaController.text.trim(),
                                town: townController.text.trim(),
                                state: state ?? '',
                                mobileNo: mobileNumberController.text.trim(),
                                pincode: pincodeController.text.trim(),
                              ),
                            );
                            alert(
                              'Update Address',
                              'Address Updated Successfully',
                              ToastificationType.success,
                            );
                          }
                        } else {
                          alert(
                            'Fill the field',
                            'Please fill the field first',
                            ToastificationType.info,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 26),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
    String? helper,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: inputType,
          validator: (value) => value!.isEmpty ? ' Please fill $label' : null,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            helperText: helper,
            border: const OutlineInputBorder(),
          ),
          maxLines: maxLines,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
