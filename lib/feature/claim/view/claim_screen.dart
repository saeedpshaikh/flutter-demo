import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dashboard/bloc/tab_bloc.dart';
import '../../dashboard/view/tab_view.dart';

class ClaimScreen extends StatefulWidget {
  const ClaimScreen({super.key});

  @override
  State<ClaimScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<ClaimScreen> {
  String selectedMethod = 'card';
  bool isLoading = false;

  final String policyName = "NYL Secure Life";
  final String policyNo = "TL123456";
  final String dueDate = "Mar 25, 2026";
  final double amount = 150.00;

  void _payNow() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text("Payment Successful"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "\$${amount.toStringAsFixed(2)} paid successfully",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Policy: $policyName"),
              Text("Transaction ID: TX123456"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => TabBloc(),
                      child: const MainTabView(),
                    ),
                  ),
                );
              },
              child: const Text("Back to Home"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentMethod({
    required String value,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bool isSelected = selectedMethod == value;

    return InkWell(
      onTap: () {
        setState(() {
          selectedMethod = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF173F6B) : Colors.grey.shade300,
            width: isSelected ? 1.8 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF173F6B)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: selectedMethod,
              activeColor: const Color(0xFF173F6B),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF173F6B),
        elevation: 0,
        title: const Text(
          "Make Payment",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Policy Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Payment Summary",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF173F6B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    policyName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text("Policy No: $policyNo"),
                  Text("Due Date: $dueDate"),
                  const Divider(height: 28),
                  const Text(
                    "Amount to Pay",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "\$${amount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF173F6B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Payment Method Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Payment Method",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF173F6B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPaymentMethod(
                    value: 'card',
                    icon: Icons.credit_card,
                    title: 'Credit Card',
                    subtitle: '**** **** **** 1234',
                  ),
                  _buildPaymentMethod(
                    value: 'upi',
                    icon: Icons.phone_android,
                    title: 'UPI',
                    subtitle: 'Google Pay / PhonePe / Paytm',
                  ),
                  _buildPaymentMethod(
                    value: 'netbanking',
                    icon: Icons.account_balance,
                    title: 'Net Banking',
                    subtitle: 'All major banks supported',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Pay Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isLoading ? null : _payNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF173F6B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
                    : Text(
                  "Pay \$${amount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}