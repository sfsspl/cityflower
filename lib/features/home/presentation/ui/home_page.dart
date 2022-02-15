import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:city_flower/core/core_widgets/core_widgets.dart';
import 'package:city_flower/core/network/vo/status.dart';
import 'package:city_flower/core/user/bloc/user_bloc.dart';
import 'package:city_flower/features/home/presentation/bloc/home_bloc.dart';
import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';
import 'package:city_flower/features/register/presentation/ui/register_page.dart';
import 'package:city_flower/features/user/domain/entity/my_cf_card_entity.dart';
import 'package:city_flower/features/user/domain/entity/user_entity.dart';
import 'package:city_flower/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_number/sliding_number.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/navigation.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state.userDetails != null &&
                      state.userDetails.status == STATUS.success) {
                    UserEntity _user = state.userDetails.data;
                    return UserAccountsDrawerHeader(
                        accountName: Text(_user.name),
                        accountEmail: Text(_user.email??''));
                  }
                  return Container();
                },
              ),
              ListTile(
                onTap: (){
                  navToRegister(context: context,  request_type: REQUEST_TYPE.CHANGE_PASSWORD);
                },
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  _logout(context);
                },
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('City Flower'),
          actions: [
            IconButton(
                icon: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
                  ),
                ),
                onPressed: () {}),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
          ],
        ),
        body: _HomePageBody(),
      ),
    );
  }

  Future<void> _logout(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(LogoutEvent());
  }
}

class _HomePageBody extends StatefulWidget {
  @override
  State<_HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<_HomePageBody> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(LoadUserDetailsEvent());
    BlocProvider.of<HomeBloc>(context).add(LoadHomePage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomePageState>(
          listener: (context, state) {
            if (state.myCfCardResource.status == STATUS.error) {
              showSnackBarMessage(
                  context, state.myCfCardResource.failure.message);
            }
            if (state.bannerResource.status == STATUS.error) {
              showSnackBarMessage(
                  context, state.bannerResource.failure.message);
            }
          },
        ),
        BlocListener<UserBloc, UserState>(listener: (context, state) {
          if (state.logoutState != null) {
            if (state.logoutState.status == STATUS.loading) {
              showProgressLoading(context);
            }
            if (state.logoutState.status == STATUS.error) {
              Navigator.of(context).pop();
              showSnackBarMessage(context, state.logoutState.failure.message);
            } else if (state.logoutState.status == STATUS.success) {
              Navigator.of(context).pop();
              navToLogin(context, launchMode: LAUNCH_MODE.SINGLE_TOP);
            }
          }
        })
      ],
      child: BlocBuilder<HomeBloc, HomePageState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    state.bannerResource.status == STATUS.loading
                        ? AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : state.bannerResource.status == STATUS.success
                            ? (state.bannerResource.data as List<dynamic>)
                                    .isEmpty
                                ? Container()
                                : Container(
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                          viewportFraction: .8,
                                          autoPlay: true,
                                          aspectRatio: 16 / 9,
                                          enlargeCenterPage: true),
                                      items: (state.bannerResource.data
                                              as List<String>)
                                          .map(
                                            (item) => Container(
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Image.network(item,
                                                  fit: BoxFit.cover,
                                                  width: 1000),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )
                            : Container(),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state.userDetails.status == STATUS.success) {
                            UserEntity _userData = state.userDetails.data;
                            return Text(
                              'Welcome ${_userData.name}!',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    state.myCfCardResource.status == STATUS.success
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Available Point: ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SlidingNumber(
                                  number: (state.myCfCardResource.data
                                              as MyCFCardEntity)
                                          .pointBalance ??
                                      0,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOutQuint,
                                ),
                                Text(
                                  ' Pts',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 16,
                    ),
                    GridView.count(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.8,
                      mainAxisSpacing: 10,
                      children: [
                        GridMenu(
                            title: 'Points History',
                            onClick: () {
                              navToPointsHistory(context);
                            }),
                        GridMenu(
                            title: 'Location',
                            onClick: () {
                              navToOutletList(context: context);
                            }),
                        GridMenu(
                            title: 'Promotion',
                            onClick: () {
                              navToPromotions(context,
                                  promotionType: PROMOTION_TYPE.normal);
                            }),
                        GridMenu(
                          title: 'Loyalty Promotion',
                          onClick: () {
                            navToPromotions(context,
                                promotionType: PROMOTION_TYPE.special);
                          },
                        ),
                        GridMenu(
                          title: 'Buy Online',
                          onClick: () {
                            _openAppStore();
                          },
                        ),
                        GridMenu(
                          title: 'Go to MY CF Card',
                          onClick: () {
                            navToMyCFCard(context: context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          _launchUrl(
                              'https://www.facebook.com/cityflowerarabia');
                        },
                        child: SvgPicture.asset('assets/icons/facebook.svg')),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _launchUrl(
                            'https://www.instagram.com/cityflower_arabia/');
                      },
                      child: Image.asset(
                        'assets/icons/instagram.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _launchUrl('https://www.cityflowerretail.com');
                      },
                      child: Image.asset(
                        'assets/icons/web.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        },
      ),
    );
  }

  void _launchUrl(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void _openAppStore() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      _launchUrl(
          'https://apps.apple.com/in/app/city-flower-retail/id1530165985');
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      _launchUrl(
          'https://play.google.com/store/apps/details?id=com.techworks.cityflower');
    }
  }
}

class GridMenu extends StatelessWidget {
  final String title;
  final Function() onClick;

  const GridMenu({Key key, @required this.title, @required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Material(
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.blue),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
