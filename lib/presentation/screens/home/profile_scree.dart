import 'package:ecom/core/ui.dart';
import 'package:ecom/data/models/user_model.dart';
import 'package:ecom/logic/cubits/user_cubits/useer_state.dart';
import 'package:ecom/logic/cubits/user_cubits/user_cubit.dart';
import 'package:ecom/presentation/screens/order/my_order_screen.dart';
import 'package:ecom/presentation/screens/user/edit_profile.dart';
import 'package:ecom/presentation/widgets/link_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScree extends StatefulWidget {
  const ProfileScree({super.key});

  @override
  State<ProfileScree> createState() => _ProfileScreeState();
}

class _ProfileScreeState extends State<ProfileScree> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
     
      if (state is UserLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is UserErrorState) {
        return Center(
          child: Text(state.message),
        );
      }
      if (state is UserLoggedInState) {
      
        return userprofile(state.userModel);
      }
      return const Center(
        child: Text("An Error Occourd"),
      );
    });
  }
  
Widget userprofile(UserModel user) {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.fullName ?? "ram",
              style: TextStyles.heading3.copyWith(color: Colors.black)),
          Text(
            user.email!,
            style: TextStyles.body2,
          ),
          LinkButton(
            text: "Edit Profile",
            onPressed: () {Navigator.pushNamed(context, EditProfileScreen.routeName);},
          )
        ],
      ),
      const Divider(),
      ListTile( leading:  const Icon(CupertinoIcons.cube_box_fill,),contentPadding: EdgeInsets.zero,
        onTap: () {Navigator.pushNamed(context, MyOrderScreen.routename);},
        title:  Text("My Orders",style: TextStyles.body1,),
      ),
      ListTile( leading:  const Icon(Icons.policy_outlined ,),contentPadding: EdgeInsets.zero,
        onTap: () {},
        title: Text("Privacy and policy",style: TextStyles.body1,),  
      ),
      ListTile( leading:  const Icon(Icons.contact_emergency ,),contentPadding: EdgeInsets.zero,
        onTap: () {}, 
        title: Text("Contact Us",style: TextStyles.body1),
      ),
      ListTile(   
        leading:  Icon(Icons.exit_to_app, color:AppColors.red ,),contentPadding: EdgeInsets.zero,
        onTap: () {BlocProvider.of<UserCubit>(context).signOut();},
        title: Text("Sign Out",style: TextStyles.body1.copyWith(color: AppColors.red),),
      )
    ],
  );
}

}
