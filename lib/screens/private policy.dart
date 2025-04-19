import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE4F5DE),
      body: SafeArea(
        child: Column(
          children: [

            Container(
              color: const Color(0xffE4F5DE),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back_ios),
                  SizedBox(width: 8),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Single Divider below title
            const Divider(
              color: Colors.black54,
              thickness: 1,
              height: 0,
            ),

            // Scrollable content
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bhargavi Enterprises Application\nEffective Date: [3-5-2025]\n',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      '1. Introduction\nBhargavi Enterprises ("Company," "we," "us," or "our") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use the Bhargavi Enterprises Application ("Bhargavi Enterprises").',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      '\n2. Information We Collect\nWe may collect and process the following types of information:\n• Personal Information: Name, email address, phone number, mailing address, and other contact details.\n• Usage Data: IP address, device information, browser type, operating system, and app usage statistics.\n• Location Data: If permitted, we may collect your geographic location for relevant services.\n• Payment Information: If applicable, payment details for transactions.\n• Third-Party Information: Data obtained from third-party integrations or linked accounts.',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      '\n3. How We Use Your Information\nWe use the collected data to:\n• Provide and improve the Application.\n• Personalize user experiences.\n• Process transactions and manage orders.\n• Send updates, promotional materials, and customer support responses.\n• Ensure security, fraud prevention, and compliance with legal obligations.',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      '\n4. Sharing Your Information\nWe may share information with:\n• Service Providers: Third-party vendors assisting in Application functionality.\n• Legal Authorities: When required by law or to protect our rights.\n• Business Transfers: In case of a merger, sale, or acquisition.',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      '\n5. Data Security\nWe implement industry-standard security measures to protect your data. However, no method of transmission over the internet is 100% secure, and we cannot guarantee absolute security.',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

