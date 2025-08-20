import 'package:flutter/material.dart';
import 'package:online_shop/screens/Profile/Provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
   Provider.of<ProfileProvider>(context, listen: false).getProfile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          if (profile.profileModel == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 50
              ,backgroundImage: NetworkImage(profile.profileModel!.avatar.toString()) ,),
              Text(profile.profileModel!.name.toString()),
              Text(profile.profileModel!.email.toString()),
            ],
          );
        },
      ),
    );
  }
}
