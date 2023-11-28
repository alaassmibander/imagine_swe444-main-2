import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imagine_swe/screens/learn.dart';
import 'package:imagine_swe/widgets/my_list_title.dart';
import 'package:imagine_swe/screens/Profile.dart';
import 'package:imagine_swe/screens/payment.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            //header photo
            const DrawerHeader(
                child: Image(image: AssetImage('assets/images/rocket.png'))),

            // home list title
            MyListTitle(
              icon: Icons.home,
              text: 'H O M E',
              onTap: () => Navigator.pop(context),
            ),

            // profile
            MyListTitle(
              icon: Icons.person,
              text: 'P R O F I L E',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const uProfile()));
              },
            ),
            MyListTitle(
              icon: Icons.credit_card,
              text: 'S U B S C R I P T I O N S ',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const payment()));
              },
            ),
            MyListTitle(
              icon: Icons.help,
              text: 'L E A R N',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Learn()));
              },
            ),
          ],
        ),

        // Logout
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: MyListTitle(
              icon: Icons.logout,
              text: 'L O G O U T ',
              onTap: () => FirebaseAuth.instance.signOut()),
        )
      ]),
    );
  }
}
