import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_flower/core/core_widgets/core_widgets.dart';
import 'package:city_flower/core/network/vo/status.dart';
import 'package:city_flower/features/outlet_list/domain/entity/outlet_list_entity.dart';
import 'package:city_flower/features/outlet_list/presentation/bloc/outlet_list_bloc.dart';
import 'package:city_flower/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class OutletListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OutletListBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Outlets'),
        ),
        body: _OutletListPageBody(),
      ),
    );
  }
}

class _OutletListPageBody extends StatefulWidget {
  @override
  State<_OutletListPageBody> createState() => _OutletListPageBodyState();
}

class _OutletListPageBodyState extends State<_OutletListPageBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OutletListBloc>(context).add(GetOutletListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OutletListBloc, OutletListState>(
      listener: (context, state) {
        if (state.outletList.status == STATUS.error) {
          showSnackBarMessage(context, state.outletList.failure.message);
        }
      },
      child: BlocBuilder<OutletListBloc, OutletListState>(
        builder: (context, state) {
          if (state.outletList.status == STATUS.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.outletList.status == STATUS.success) {
            List<OutletListEntity> _outlets = state.outletList.data;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<String>(
                    items: (state.cityList.data as Set<String>)
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(state.selectedCity),
                    ),
                    onChanged: (text) {
                      print('onChanged $text');
                      BlocProvider.of<OutletListBloc>(context)
                          .add(SelectCityEvent(city: text));
                    },
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return _OutletItemView(_outlets[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 4,
                        );
                      },
                      itemCount: _outlets.length),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _OutletItemView extends StatelessWidget {
  OutletListEntity outlet;

  _OutletItemView(this.outlet);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: outlet.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              outlet.name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(outlet.address +
                                ", " +
                                outlet.city +
                                " - " +
                                outlet.postalCode),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _navigate(context,outlet.lat, outlet.lng);
                          },
                          icon: Icon(
                            Icons.navigation,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context,double lat, double lng) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      showSnackBarMessage(context, "Unable to navigate");
    }
  }
}
