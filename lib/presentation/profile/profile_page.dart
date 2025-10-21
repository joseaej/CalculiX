import 'package:calculix/core/shared_widgets/avatar_circle.dart';
import 'package:calculix/core/shared_widgets/buttons/principal_rectangular_button.dart';
import 'package:calculix/presentation/auth/auth_notifier.dart';
import 'package:calculix/presentation/profile/storage_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    Future.microtask(() async {
      final user = ref.read(authNotifierProvider).user!;
      await ref
          .read(storageNotierProvider.notifier)
          .getImageFromUser(user: user);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserAvatar(
                userName: "Prueba",
                imageUrl: ref.watch(storageNotierProvider).imageUrl,
                onEditPressed: () {
                  ref
                      .watch(storageNotierProvider.notifier)
                      .uploadImageFromUser(
                        user: ref.watch(authNotifierProvider).user!,
                        imageSource: ImageSource.camera,
                      );
                  ref
                      .watch(storageNotierProvider.notifier)
                      .getImageFromUser(
                        user: ref.watch(authNotifierProvider).user!,
                      );
                },
              ),
              Text(ref.read(authNotifierProvider).user!.id),
              principalRectangularButton(
                onPressed: () {
                  ref.watch(authNotifierProvider.notifier).signOut();
                  Navigator.pushReplacementNamed(context, "/register");
                },
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
