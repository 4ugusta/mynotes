import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Verify Email', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(children: [
        const Text('Please verify your email address:'),
        TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
              await user?.reload(); // Reload the user
              final userReloaded = FirebaseAuth.instance.currentUser;
              if (userReloaded?.emailVerified ?? false) {
                if (mounted) {
                  // Check if the VerifyEmailView is still mounted
                  Navigator.of(context)
                      .pop(); // Go back if the email is verified
                }
              }
            },
            child: const Text('Send email verification'))
      ]),
    );
  }
}
