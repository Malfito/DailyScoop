import 'package:flutter/material.dart';

class StepperWidget extends StatelessWidget {
  final int currentStep;
  StepperWidget({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        int step = index + 1;
        return Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: currentStep >= step ? Colors.green : Colors.grey[300],
              child: Text(
                "$step",
                style: TextStyle(
                  color: currentStep >= step ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (step < 3)
              Container(
                width: 30,
                height: 3,
                color: currentStep > step ? Colors.green : Colors.grey[300],
              ),
          ],
        );
      }),
    );
  }
}
