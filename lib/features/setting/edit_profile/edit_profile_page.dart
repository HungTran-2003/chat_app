import 'package:chat_app/core/global/user/user_cubit.dart';
import 'package:chat_app/core/theme/app_colors.dart';
import 'package:chat_app/core/widgets/image/app_avatar_image.dart';
import 'package:chat_app/data/service/network/cloudinary_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _cloudinaryRepository = CloudinaryRepository();
  final _imagePicker = ImagePicker();

  late TextEditingController _nameController;
  late TextEditingController _sloganController;
  late TextEditingController _emailController;

  String? _avatarPath;
  bool _isUploadingAvatar = false;
  bool _isSavingProfile = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().state.user;
    
    _nameController = TextEditingController(text: user?.userName ?? "");
    _sloganController = TextEditingController(text: user?.slogan ?? "");
    _emailController = TextEditingController(text: user?.email ?? "");
    _avatarPath = user?.avatarPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadAvatar(ImageSource source) async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 500,
      );

      if (file == null) return;

      setState(() {
        _isUploadingAvatar = true;
      });

      // Upload the picked image to Cloudinary using our robust Dio repository
      final result = await _cloudinaryRepository.uploadFileDirect(
        filePath: file.path,
      );

      setState(() {
        _avatarPath = result.secureUrl;
        _isUploadingAvatar = false;
      });

      _showSnackBar("Tải lên ảnh đại diện thành công!", isError: false);
    } catch (e) {
      setState(() {
        _isUploadingAvatar = false;
      });
      _showSnackBar("Tải lên ảnh thất bại: $e", isError: true);
    }
  }

  void _showAvatarPickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Thay đổi ảnh đại diện",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOptionItem(
                      icon: Icons.camera_alt_rounded,
                      color: Colors.blue,
                      label: "Chụp ảnh mới",
                      onTap: () {
                        Navigator.pop(context);
                        _pickAndUploadAvatar(ImageSource.camera);
                      },
                    ),
                    _buildOptionItem(
                      icon: Icons.photo_library_rounded,
                      color: Colors.purple,
                      label: "Chọn từ thư viện",
                      onTap: () {
                        Navigator.pop(context);
                        _pickAndUploadAvatar(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfileChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSavingProfile = true;
    });

    final success = await context.read<UserCubit>().updateProfile(
          userName: _nameController.text.trim(),
          slogan: _sloganController.text.trim(),
          avatarPath: _avatarPath,
        );

    setState(() {
      _isSavingProfile = false;
    });

    if (success) {
      _showSnackBar("Cập nhật thông tin hồ sơ thành công!", isError: false);
      if (mounted) {
        Navigator.pop(context); // Go back to settings page
      }
    } else {
      _showSnackBar("Không thể lưu thông tin. Vui lòng thử lại.", isError: true);
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- Premium Header Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Spacer to center title
                ],
              ),
            ),
            const SizedBox(height: 12),
            // --- Rounded Card Container ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Sheet Pill Handle
                          Center(
                            child: Container(
                              width: 36,
                              height: 4,
                              margin: const EdgeInsets.only(top: 8, bottom: 24),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5E5E5),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // --- Edit Avatar Center Section ---
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFF3F6F6),
                                      width: 4,
                                    ),
                                  ),
                                  child: Opacity(
                                    opacity: _isUploadingAvatar ? 0.4 : 1.0,
                                    child: AppAvatarImage(
                                      path: _avatarPath,
                                      size: 100,
                                    ),
                                  ),
                                ),
                                if (_isUploadingAvatar)
                                  const Positioned.fill(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                if (!_isUploadingAvatar)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: _showAvatarPickerOptions,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt_rounded,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          // --- Full Name Input ---
                          _buildInputField(
                            controller: _nameController,
                            label: "Tên hiển thị",
                            hint: "Nhập tên của bạn",
                            icon: Icons.person_outline_rounded,
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Tên hiển thị không được bỏ trống";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // --- Slogan Input ---
                          _buildInputField(
                            controller: _sloganController,
                            label: "Trạng thái / Slogan",
                            hint: "Ví dụ: Never give up 💪",
                            icon: Icons.emoji_emotions_outlined,
                            validator: (val) => null, // Slogan is optional
                          ),
                          const SizedBox(height: 20),
                          // --- Email Input (Locked) ---
                          _buildInputField(
                            controller: _emailController,
                            label: "Địa chỉ Email",
                            hint: "email@example.com",
                            icon: Icons.email_outlined,
                            isReadOnly: true,
                            trailing: const Icon(
                              Icons.lock_outline_rounded,
                              color: AppColors.tertiary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 48),
                          // --- Save Changes Button ---
                          ElevatedButton(
                            onPressed: _isSavingProfile || _isUploadingAvatar
                                ? null
                                : _saveProfileChanges,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: Colors.grey[300],
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: _isSavingProfile
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    "Lưu Thay Đổi",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isReadOnly = false,
    Widget? trailing,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.tertiary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: isReadOnly,
          validator: validator,
          style: TextStyle(
            fontSize: 16,
            color: isReadOnly ? AppColors.tertiary : AppColors.textBlack,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
            prefixIcon: Icon(icon, color: AppColors.tertiary, size: 22),
            suffixIcon: trailing,
            filled: true,
            fillColor: isReadOnly ? const Color(0xFFF9FAFA) : const Color(0xFFF3F6F6),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
