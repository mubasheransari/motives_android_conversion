import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Features/edit_profile_screen.dart';
import 'package:motives_android_conversion/widget/gradient_button.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController employeeIdController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController distributorController;

  File? _profileImage;

  @override
  void initState() {
    super.initState();

   // final loginModel = context.read<GlobalBloc>().state.loginModel;
    
    final info = context.read<GlobalBloc>().state.loginModel;

    // ⚡ Populate controllers with API data safely
    nameController = TextEditingController(
      text: info!.userinfo!.userName ?? "",
    );
    employeeIdController = TextEditingController(
        text: info.userinfo!.userId ?? "",
    );
    phoneController = TextEditingController(
        text: info.userinfo!.phone ?? "",
    );
    addressController = TextEditingController(
       text: info.distributors!.first.address1 ?? "",
    );
    distributorController = TextEditingController(
        text: info.userinfo!.distributionName ?? "",
    );
  }

  @override
  void dispose() {
    // ✅ Dispose controllers to avoid memory leaks
    nameController.dispose();
    employeeIdController.dispose();
    phoneController.dispose();
    addressController.dispose();
    distributorController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: GradientText("Profile", fontSize: 24),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[200],
          elevation: 8,
          shadowColor: isDark
              ? Colors.purple.withOpacity(0.4)
              : Colors.grey.withOpacity(0.2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile Picture
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('assets/profile_icon.png')
                              as ImageProvider,
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                _customTextField(
                  controller: nameController,
                  hint: "Full Name",
                  icon: Icons.person_outline,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                _customTextField(
                  controller: employeeIdController,
                  hint: "Employee ID",
                  icon: Icons.badge_outlined,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                _customTextField(
                  controller: phoneController,
                  hint: "Phone",
                  icon: Icons.phone,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                _customTextField(
                  controller: addressController,
                  hint: "Address",
                  icon: Icons.location_on_outlined,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                _customTextField(
                  controller: distributorController,
                  hint: "Distributor",
                  icon: Icons.shop_rounded,
                  isDark: isDark,
                ),
                // const SizedBox(height: 24),

                // GradientButton(
                //   text: "Edit Profile",
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => EditProfileScreen(),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isDark,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
        prefixIcon: Icon(icon, color: Colors.cyan),
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}


/*class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // You can also offer camera option
      imageQuality: 70,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: GradientText("Profile", fontSize: 24),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[200],
          elevation: 8,
          shadowColor: isDark ? Colors.purple.withOpacity(0.4) : Colors.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile Picture
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('assets/profile_icon.png')
                              as ImageProvider,
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   right: 0,
                    //   child: GestureDetector(
                    //     onTap: _pickImage,
                    //     child: Container(
                    //       padding: const EdgeInsets.all(6),
                    //       decoration: const BoxDecoration(
                    //         color: Colors.purpleAccent,
                    //         shape: BoxShape.circle,
                    //       ),
                    //       child: const Icon(Icons.edit, size: 18, color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 30),

                // GradientText("My Information", fontSize: 22),
                // const SizedBox(height: 20),

                _customTextField(
                  controller: nameController,
                  hint: "Sohrab Khan",
                  icon: Icons.person_outline,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                _customTextField(
                  controller: employeeIdController,
                  hint: "Order Booker",
                  icon: Icons.badge_outlined,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                _customTextField(
                  controller: phoneController,
                  hint: "Karachi",
                  icon: Icons.location_city,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                _customTextField(
                  controller: addressController,
                  hint: "Address",
                  icon: Icons.location_on_outlined,
                  isDark: isDark,
                ),
                   const SizedBox(height: 16),

                _customTextField(
                  controller: phoneController,
                  hint: "Distributor",
                  icon: Icons.shop_rounded,
                  isDark: isDark,
                ),
                const SizedBox(height: 24),

                GradientButton(
                  text: "Edit Profile",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfileScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool isDark,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
        prefixIcon: Icon(icon, color: Colors.cyan),
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}*/

