import 'package:flutter/material.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';

class SubscriberTypeScreen extends StatefulWidget {
  @override
  State<SubscriberTypeScreen> createState() => _SubscriberTypeScreenState();
}

class _SubscriberTypeScreenState extends State<SubscriberTypeScreen> {
  String selectedType = "student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "You Are :",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      SizedBox(
        height: kVerticalSpace["meduim"],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => setState(() {
                selectedType = "student";
              }),
              child: typeUserCard(
                  title: "Student",
                  isActive: selectedType == "student",
                  iconUrl: "assets/icons/student-icon.png"),
            ),
          ),
          SizedBox(width: 40),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () => setState(() {
                      selectedType = "prof";
                    }),
                child: typeUserCard(
                    title: "Professor",
                    isActive: selectedType == "prof",
                    iconUrl: "assets/icons/prof-icon.png")),
          ),
        ],
      )
    ])));
  }
}

class typeUserCard extends StatelessWidget {
  bool isActive;
  String iconUrl;
  String title = "";
  typeUserCard({this.isActive = false, this.iconUrl = "", this.title = ""});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
        decoration: isActive
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondaryContainer,
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary, width: 2))
            : BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: Center(
                    child: iconUrl.isEmpty
                        ? Container()
                        : Image.asset(iconUrl, width: 60)),
              ),
              SizedBox(
                height: kVerticalSpace["small"],
              ),
              Center(
                  child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ))
            ],
          ),
        ));
  }
}
