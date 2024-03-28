import 'package:bank_sha/shared/shared_method.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:bank_sha/ui/pages/profile/widget/profile_menu_item.dart';
import 'package:bank_sha/ui/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            customSnackBar(context, state.e);
          }

          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthSuccess) {
            print('${state.user.profilePicture}');
            return ListView(
              padding: const EdgeInsets.only(
                right: 24,
                left: 24,
              ),
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 22,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: state.user.profilePicture == ''
                                ? const AssetImage('assets/img_profile.png')
                                : NetworkImage(state.user.profilePicture!)
                                    as ImageProvider,
                          ),
                        ),
                        child: state.user.verified == '1' ?  Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/ic_check.png',
                            width: 30,
                          ),
                        ) : null,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        '${state.user.name}',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ProfileMenuItem(
                        urlIcon: 'assets/ic_edit_profile.png',
                        title: 'Edit Profile',
                        onTap: () async {
                          if (await Navigator.pushNamed(context, '/pin') ==
                              true) {
                            Navigator.pushNamed(context, '/edit-profile');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ProfileMenuItem(
                        urlIcon: 'assets/ic_pin.png',
                        title: 'My PIN',
                        onTap: () async {
                          if (await Navigator.pushNamed(context, '/pin') ==
                              true) {
                            Navigator.pushNamed(context, '/edit-pin-profile');
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ProfileMenuItem(
                        urlIcon: 'assets/ic_wallet.png',
                        title: 'Wallet Setting',
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ProfileMenuItem(
                        urlIcon: 'assets/ic_my_reward.png',
                        title: 'My Rewards',
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ProfileMenuItem(
                        urlIcon: 'assets/ic_help.png',
                        title: 'Help Center',
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ProfileMenuItem(
                        urlIcon: 'assets/ic_logout.png',
                        title: 'Log Out',
                        onTap: () async {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 87,
                ),
                CustomTextButton(
                  title: 'Report a Problem',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
