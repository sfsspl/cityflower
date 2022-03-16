import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_flower/core/core_widgets/core_widgets.dart';
import 'package:city_flower/core/util/date_formatter.dart';
import 'package:city_flower/features/promotion/domain/entity/promotion_entity.dart';
import 'package:city_flower/features/promotion/presentation/bloc/promotion_bloc.dart';
import 'package:city_flower/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

class PromotionPage extends StatelessWidget {
  final PROMOTION_TYPE type;

  const PromotionPage({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PromotionBloc>(
      create: (_) => serviceLocator(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(type == PROMOTION_TYPE.special
              ? 'Loyalty Promotion'
              : 'Promotion'),
        ),
        body: _PromotionsPageBody(
          type: type,
        ),
      ),
    );
  }
}

class _PromotionsPageBody extends StatefulWidget {
  final PROMOTION_TYPE type;

  const _PromotionsPageBody({Key key, this.type}) : super(key: key);

  @override
  State<_PromotionsPageBody> createState() => _PromotionsPageBodyState();
}

class _PromotionsPageBodyState extends State<_PromotionsPageBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PromotionBloc>(context)
        .add(LoadPromotionsEvent(type: widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PromotionBloc, PromotionState>(
      listener: (_, state) {
        if (state is PromotionsLoadFailedState) {
          showSnackBarMessage(context, state.message);
        }
      },
      child: BlocBuilder<PromotionBloc, PromotionState>(
        builder: (contect, state) {
          if (state is PromotionLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PromotionLoadedState) {
            List<PromotionEntity> _promotions = state.promotions;
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 4,
                );
              },
              itemBuilder: (context, index) {
                return widget.type == PROMOTION_TYPE.normal
                    ? _NormalPromotionView(
                        promotionEntity: state.promotions[index])
                    : _NormalPromotionView(
                        promotionEntity: state.promotions[index]);
              },
              itemCount: _promotions.length,
            );
          }
          return Container();
        },
      ),
    );
  }
}

class _NormalPromotionView extends StatelessWidget {
  final PromotionEntity promotionEntity;

  _NormalPromotionView({this.promotionEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          _showFullScreenImage(context, promotionEntity.imageUrl);
        },
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(fit: StackFit.expand, children: [
            CachedNetworkImage(
              imageUrl: promotionEntity.imageUrl,
              fit: BoxFit.fill,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.black38),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promotionEntity.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        promotionEntity.message,
                        style: TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Live upto: ${formatTransactionDate(dateTime: promotionEntity.liveUpto)}',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}

class _SpecialPromotionView extends StatelessWidget {
  final PromotionEntity promotionEntity;

  _SpecialPromotionView({this.promotionEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          _showFullScreenImage(context, promotionEntity.imageUrl);
        },
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/logo/logo.png'),
                  ),
                ),
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.black38),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promotionEntity.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showFullScreenImage(BuildContext context, String imageUrl) {
  Navigator.of(context).push(
    MaterialPageRoute(
        builder: (context) => Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  PhotoView(
                    imageProvider: CachedNetworkImageProvider(
                      imageUrl,
                    ),
                    loadingBuilder: (context, _) => CircularProgressIndicator(),
                  ),
                  Positioned(
                    left: 4,
                    top: 40,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
        fullscreenDialog: true),
  );
}
