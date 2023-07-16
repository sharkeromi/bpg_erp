import 'package:bpg_erp/utils/color_util.dart';
import 'package:bpg_erp/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HangerScanScreen extends StatelessWidget {
  const HangerScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        height: 65,
        width: 250,
        widget: const Text(
          'SEND TO \nBUYER',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        navigation: () {},
      ),
      backgroundColor: Color(ColorUtil.instance.hexColor("#e7f0f9")),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Card To Text",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0096b5),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                height: 100,
                width: 100,
                widget: Padding(
                  padding: const EdgeInsets.only(bottom: 6.0, right: 4),
                  child: const Icon(
                    Icons.add_a_photo_rounded,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                navigation: () {
                  //POP UP
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                //height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text(
                        'Uploaded Image',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text(
                        'Result',
                        style: TextStyle(fontSize: 20),
                      ),
                      // Extracted Text
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
