import 'package:barcode_widgets/barcode_flutter.dart';
import 'package:city_flower/core/core_widgets/core_widgets.dart';
import 'package:city_flower/core/user/bloc/user_bloc.dart';
import 'package:city_flower/features/cf_card/presentation/bloc/cf_card_bloc.dart';
import 'package:city_flower/features/user/domain/entity/my_cf_card_entity.dart';
import 'package:city_flower/features/user/domain/entity/user_entity.dart';
import 'package:city_flower/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/vo/status.dart';

class CFCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CfCardBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: CFCardPageBody(),
      ),
    );
  }
}

class CFCardPageBody extends StatefulWidget {
  @override
  State<CFCardPageBody> createState() => _CFCardPageBodyState();
}

class _CFCardPageBodyState extends State<CFCardPageBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CfCardBloc>(context).add(LoadCfCardPageEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CfCardBloc, CfCardState>(
      listener: (_, state) {
        if (state.cfCardResource.status == STATUS.error) {
          showSnackBarMessage(context, state.cfCardResource.failure.message);
        }
      },
      child: BlocBuilder<CfCardBloc, CfCardState>(
        builder: (context, state) {
          if (state.cfCardResource.status == STATUS.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.cfCardResource.status == STATUS.success) {
            MyCFCardEntity _card = state.cfCardResource.data;
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade800,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade600,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'mycf',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Loyalty card',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state.userDetails.status == STATUS.success) {
                                UserEntity _userData = state.userDetails.data;
                                return Text(
                                  _userData.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                );
                              }
                              return Container();
                            },
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Card Number: ${_card.cardNumber}',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Points: ${_card.pointBalance}',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state.userDetails.status == STATUS.success) {
                                UserEntity _userData = state.userDetails.data;
                                return Text(
                                  _userData.email??'',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'SCAN ME',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(20),
                            child: BarCodeImage(
                              params: Code128BarCodeParams(
                                _card.cardNumber,
                                lineWidth: 2.0,
                                // width for a single black/white bar (default: 2.0)
                                barHeight: 90.0,
                                // height for the entire widget (default: 100.0)
                                withText:
                                    true, // Render with text label or not (default: false)
                              ),
                              onError: (error) {
                                // Error handler
                                print('error = $error');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
