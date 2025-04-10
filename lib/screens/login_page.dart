import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? verificationId;
  bool isOtpSent = false;
  bool isLoading = false;
  Color buttonColor = const Color(0xFFD9D9D9);

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_validateAndSetColor);
  }

  @override
  void dispose() {
    phoneController.removeListener(_validateAndSetColor);
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void _validateAndSetColor() {
    final isValid = RegExp(r'^[6-9]\d{9}$').hasMatch(phoneController.text);
    setState(() {
      buttonColor = isValid ? const Color(0xFF008000) : const Color(0xFFD9D9D9);
    });
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return 'Enter valid 10-digit Indian phone number';
    }
    return null;
  }

  void _sendOtp() async {
    final phone = "+91${phoneController.text.trim()}";

    setState(() => isLoading = true);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        await _storeUserData();
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification failed: ${e.message}')),
        );
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
          isOtpSent = true;
          isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  void _verifyOtpAndLogin() async {
    final otp = otpController.text.trim();
    if (verificationId == null || otp.isEmpty) return;

    setState(() => isLoading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      await _storeUserData();
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verification failed: $e')),
      );
    }
  }

  Future<void> _storeUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final phone = user?.phoneNumber ?? "+91${phoneController.text.trim()}";

    await FirebaseFirestore.instance.collection('users').doc(phone).set({
      'uid': user?.uid,
      'phone': phone,
      'created_at': FieldValue.serverTimestamp(),
    });

    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login successful!')),
    );

    // You can navigate to home here
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffE4F5DE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo and company name
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Bhargavi Enterprises',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Background image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/logimage.png',
                    width: double.infinity,
                    height: width > 600 ? 300 : 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bhargavi Enterprises',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1B622C)),
                ),
                const SizedBox(height: 6),
                const Text(
                  'India’s Healthiest products',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // Phone number input
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                  validator: validatePhone,
                  enabled: !isOtpSent,
                ),
                const SizedBox(height: 16),
                // OTP field
                if (isOtpSent)
                  TextFormField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'Enter OTP',
                      border: OutlineInputBorder(),
                      counterText: '',

                    ),
                  ),
                const SizedBox(height: 20),
                // Action button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: isLoading
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        isOtpSent
                            ? _verifyOtpAndLogin()
                            : _sendOtp();
                      }
                    },
                    child: Text(
                      isLoading
                          ? 'Please wait...'
                          : isOtpSent
                          ? 'Verify OTP'
                          : 'Get Started',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
