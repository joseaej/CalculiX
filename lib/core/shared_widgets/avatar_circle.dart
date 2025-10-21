import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:calculix/core/config/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final VoidCallback? onEditPressed;
  final String? userName;

  const UserAvatar({
    super.key,
    this.imageUrl,
    this.radius = 20,
    this.onEditPressed,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = radius.w;
    final double editButtonSize = avatarRadius * 0.5;
    final double iconPadding = editButtonSize * 0.1;

    Widget avatarContent;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = CircleAvatar(
        radius: avatarRadius,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: NetworkImage(imageUrl!),
        onBackgroundImageError: (exception, stackTrace) {
          debugPrint('Error loading avatar image: $exception');

          avatarContent = _buildPlaceholderAvatar(avatarRadius);
        },
      );
    } else if (userName != null && userName!.isNotEmpty) {
      avatarContent = CircleAvatar(
        radius: avatarRadius,
        backgroundColor: AppColors.primaryBlue,
        child: Text(
          userName![0].toUpperCase(),
          style: TextStyle(
            fontSize: avatarRadius * 0.8,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    } else {
      avatarContent = _buildPlaceholderAvatar(avatarRadius);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        avatarContent,

        if (onEditPressed != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditPressed,
              child: Container(
                width: editButtonSize,
                height: editButtonSize,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: editButtonSize - iconPadding * 2,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholderAvatar(double avatarRadius) {
    return CircleAvatar(
      radius: avatarRadius,
      backgroundColor: AppColors.primaryBlue,
      child: Icon(
        Icons.person,
        size: avatarRadius * 1.2,
      ),
    );
  }
}
