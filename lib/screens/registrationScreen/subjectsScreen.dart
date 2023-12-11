import 'package:flutter/material.dart';
import 'package:ostadi_frontend/constants/app_constants.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  List<Map<String, Object>> subjects = [
    {
      "id": 1,
      "name": "Math",
      "selected": false,
      "path": "assets/icons/math.png"
    },
    {
      "id": 2,
      "name": "Physics",
      "selected": true,
      "path": "assets/icons/physics.png"
    },
    {
      "id": 3,
      "name": "Arabic",
      "selected": false,
      "path": "assets/icons/arabic.png"
    },
    {"id": 4, "name": "SVT", "selected": true, "path": "assets/icons/svt.png"},
    {
      "id": 5,
      "name": "Info",
      "selected": true,
      "path": "assets/icons/programming.png"
    },
  ];
  void switchSelectObject(id) {
    for (var subject in subjects) {
      if (subject["id"] == id) {
        setState(() {
          subject["selected"] = !(subject["selected"] as bool);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo_light.png",
            width: 50,
          ),
          SizedBox(height: kVerticalSpace["small"]),
          Text("Subjects you teach:",
              style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: kVerticalSpace["meduim"]),
          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.2,
              children: subjects
                  .map((e) => Center(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => switchSelectObject(e["id"]),
                            child: SubjectItemCard(
                              imgPath: e["path"]! as String,
                              title: e["name"]! as String,
                              isSelected: e["selected"]! as bool,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectItemCard extends StatelessWidget {
  String title;
  String imgPath;
  bool isSelected;
  double? width;
  double? height;
  SubjectItemCard(
      {required this.isSelected,
      this.width,
      this.height,
      this.title = "",
      this.imgPath = ""});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Container(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(imgPath, width: (width ?? 120) - 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(title),
                  )
                ],
              ),
            ),
            if (isSelected)
              Positioned(
                  child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.slowMiddle,
                child: Center(
                  child: Icon(Icons.check,
                      color: Theme.of(context).colorScheme.onPrimary, size: 15),
                ),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle),
              ))
          ],
        ),
      ),
    );
  }
}
