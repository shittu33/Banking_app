import 'package:flutter/material.dart';
import 'package:veegil_test/constants.dart';

class AppDrawer extends StatelessWidget {
  final Function()? onToggleDrawer;

  const AppDrawer({Key? key, this.onToggleDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.0,
      child: Drawer(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: TextButton(
                onPressed: onToggleDrawer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: TPrimaryColor,
                    ),
                    Text("Back",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: DrawerItem(Icons.account_balance, "WITHDRAW",
                  opacity: 1.0, color: TPrimaryColor),
            ),
            Divider(),
            Expanded(child: DrawerItem(Icons.compare_arrows, "TRANSFER")),
            Divider(),
            Expanded(child: DrawerItem(Icons.attach_money, "DEPOSIT")),
            Divider(),
            Expanded(child: DrawerItem(Icons.account_circle, "Profile")),
            Divider(),
            Expanded(child: DrawerItem(Icons.logout, "Logout")),
            Divider()
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final opacity;
  final color;
  final icon;
  final title;

  const DrawerItem(this.icon, this.title,
      {Key? key, this.opacity = 0.3, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Icon(
              icon,
              size: 50.0,
              color: color,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 14.0, color: color)),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
