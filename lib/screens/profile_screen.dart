import 'package:flitter/utils/ui/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.state});

  final GoRouterState state;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ProfileHeader(),
            flex: 1,
          ),
          Expanded(
            child: Container(
              color: Colors.green,
              child: Center(
                child: Text('Second Container'),
              ),
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
