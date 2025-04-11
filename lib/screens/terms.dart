import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE4F5DE),
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Container(
              color: const Color(0xffE4F5DE),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios),
                  const SizedBox(width: 8),
                  const Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            // Divider below title
            const Divider(
              color: Colors.black54,
              thickness: 1,
              height: 0,
            ),
            // Content
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '''General Terms
• Bhargavi Oil reserves the right to modify or update these Terms at any time without prior notice.
• Users must be at least 18 years old to place orders.
• By using this website, you agree to comply with all applicable local, state, and federal laws.

Shipping and Return Policy
1. If a cancellation request is received before the order is processed/approved, we will cancel the order and refund the full amount.
2. A ₹50 deduction will be applied for cancellations or returns of orders that have left the shipping warehouse.
3. In case of any damage, we require customers to record unboxing videos. This will help us address any issues effectively and provide suitable solutions.

Bulk Order Information
• For bulk order retailing, or corporate gifting, contact us at 9500922881.
• A 4% to 8% discount will be offered for bulk orders, depending on volume and billing.
• Full payment is required before order processing.

Product Quality and Disclaimer
• We ensure our products meet high-quality standards, but results may vary from person to person.
• Bhargavi Oil is not responsible for any adverse reactions caused by product usage.
• Customers should read ingredient lists carefully before use, especially if they have allergies.''',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
