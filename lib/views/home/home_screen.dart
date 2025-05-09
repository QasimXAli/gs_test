import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gs_test/models/app_user.dart';
import 'package:gs_test/services/auth_service.dart';
import 'package:gs_test/utils/extensions.dart';
import 'package:gs_test/utils/theme_manager.dart';
import 'package:gs_test/utils/toast_message.dart';
import 'package:gs_test/views/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: ThemeManager.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () async {
              await authService.logout();
              ToastMessage.show(msg: "Logged out successfully");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder<List<AppUser>>(
          stream: provider.usersStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final users = snapshot.data ?? [];

            if (users.isEmpty) {
              return const Center(child: Text("No users found."));
            }

            return ListView.separated(
              separatorBuilder: (context, index) => 10.ph,
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(8),
                  child: ListTile(
                    leading: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: user.imageUrl,
                        fit: BoxFit.cover,
                        width: 48,
                        height: 48,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person, color: Colors.red),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                      ),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
