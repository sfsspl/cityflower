import 'package:city_flower/core/core_widgets/core_widgets.dart';
import 'package:city_flower/features/points_history/presentation/bloc/points_history_bloc.dart';
import 'package:city_flower/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PointsHistoryBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Points History'),
        ),
        body: _PointsHistoryPageBody(),
      ),
    );
  }
}

class _PointsHistoryPageBody extends StatefulWidget {
  @override
  State<_PointsHistoryPageBody> createState() => _PointsHistoryPageBodyState();
}

class _PointsHistoryPageBodyState extends State<_PointsHistoryPageBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PointsHistoryBloc>(context).add(GetPointsHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PointsHistoryBloc, PointsHistoryState>(
      listener: (context, state) {
        if (state is PointsHistoryLoadingFailedState) {
          showSnackBarMessage(context, state.failure.message);
        }
      },
      child: BlocBuilder<PointsHistoryBloc, PointsHistoryState>(
        builder: (context, state) {
          if (state is PointsHistoryLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PointsHistoryLoadedState) {
            return Column(
              children: [
                Material(
                  color: Colors.white,
                  elevation: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Type',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Points',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, state) {
                      return Divider(
                        height: 1,
                      );
                    },
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final _history = state.pointsHistory[index];
                      return Container(
                        color: index % 2 == 0
                            ? Colors.white
                            : Colors.blue.withOpacity(.2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                    child: Text(_history.getFormattedTime())),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(child: Text(_history.entryType)),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                    child: Text(_history.point.toString())),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: state.pointsHistory.length,
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
