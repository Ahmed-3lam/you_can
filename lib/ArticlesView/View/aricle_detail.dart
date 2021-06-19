import 'package:flutter/material.dart';

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Icon(
            Icons.bookmark_border_outlined,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(width: 25)
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Daily Life", style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text("How to manage your time",
                  style: TextStyle(fontSize: 24)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(backgroundColor: Colors.blue, radius: 30),
                SizedBox(width: 25),
                Text("By mohab Batta", style: TextStyle(fontSize: 20)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage("assets/images/inspire.png"))),
              ),
            ),
            Text(
                "Setting time constraints for completing tasks helps you be more focused and efficient."
                " Making the small extra effort "
                "to decide on how much time you need to allot"
                " for each task can also help you recognize potential problems before they arise. "
                "That way you can make plans for dealing with them.For example, assume you need to write up"
                " five reviews in time for a meeting. However,"
                " you realize that you’ll only be able to get four of them done in the time remaining"
                " before the meeting. If you become aware of this fact well in advance, you may be able to easily"
                " delegate writing up one of the reviews to someone else. However,"
                " if you hadn’t bothered to do a time check on your tasks beforehand, you might have ended"
                " up not realizing your time problem until "
                "just an hour before the meeting. At that point, it might be considerably more difficult to"
                " find someone to delegate one of the reviews to, and more difficult for them to fit the task into their day, too."),
          ],
        ),
      ),
    );
  }
}
