import 'package:cherry_components/cherry_components.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:row_collection/row_collection.dart';
import 'package:row_item/row_item.dart';
import 'package:share/share.dart';

import '../../../cubits/index.dart';
import '../../../models/index.dart';
import '../../../util/index.dart';
import '../../widgets/index.dart';

/// This view all information about a Dragon capsule model. It displays CapsuleInfo's specs.
class DragonPage extends StatelessWidget {
  final String id;

  const DragonPage(this.id);

  @override
  Widget build(BuildContext context) {
    final DragonVehicle _dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverBar(
          title: _dragon.name,
          header: SwiperHeader(
            list: _dragon.photos,
            builder: (_, index) => CacheImage(_dragon.getPhoto(index)),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () => Share.share(
                FlutterI18n.translate(
                  context,
                  'spacex.other.share.capsule.body',
                  translationParams: {
                    'name': _dragon.name,
                    'launch_payload': _dragon.getLaunchMass,
                    'return_payload': _dragon.getReturnMass,
                    'people': _dragon.isCrewEnabled
                        ? FlutterI18n.translate(
                            context,
                            'spacex.other.share.capsule.people',
                            translationParams: {
                              'people': _dragon.crew.toString()
                            },
                          )
                        : FlutterI18n.translate(
                            context,
                            'spacex.other.share.capsule.no_people',
                          ),
                    'details': Url.shareDetails
                  },
                ),
              ),
              tooltip: FlutterI18n.translate(
                context,
                'spacex.other.menu.share',
              ),
            ),
            PopupMenuButton<String>(
              itemBuilder: (context) => [
                for (final item in Menu.wikipedia)
                  PopupMenuItem(
                    value: item,
                    child: Text(FlutterI18n.translate(context, item)),
                  )
              ],
              onSelected: (text) => openUrl(_dragon.url),
            ),
          ],
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverToBoxAdapter(
            child: RowLayout.cards(children: <Widget>[
              _capsuleCard(context),
              _specsCard(context),
              _thrustersCard(context),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _capsuleCard(BuildContext context) {
    final DragonVehicle _dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.description.title',
      ),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.launch_maiden',
          ),
          _dragon.getFullFirstFlight,
        ),
        RowItem.text(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.crew_capacity',
          ),
          _dragon.getCrew(context),
        ),
        RowItem.boolean(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.active',
          ),
          _dragon.active,
        ),
        Separator.divider(),
        ExpandText(_dragon.description)
      ]),
    );
  }

  Widget _specsCard(BuildContext context) {
    final DragonVehicle _dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.specifications.title',
      ),
      child: RowLayout(children: <Widget>[
        RowItem.text(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.payload_launch',
          ),
          _dragon.getLaunchMass,
        ),
        RowItem.text(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.payload_return',
          ),
          _dragon.getReturnMass,
        ),
        RowItem.boolean(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.description.reusable',
          ),
          _dragon.reusable,
        ),
        Separator.divider(),
        RowItem.text(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.height',
          ),
          _dragon.getHeight,
        ),
        RowItem.text(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.diameter',
          ),
          _dragon.getDiameter,
        ),
        RowItem.text(
          FlutterI18n.translate(
            context,
            'spacex.vehicle.capsule.specifications.mass',
          ),
          _dragon.getMass(context),
        ),
      ]),
    );
  }

  Widget _thrustersCard(BuildContext context) {
    final DragonVehicle _dragon = context.watch<VehiclesCubit>().getVehicle(id);
    return CardCell.body(
      context,
      title: FlutterI18n.translate(
        context,
        'spacex.vehicle.capsule.thruster.title',
      ),
      child: RowLayout(children: <Widget>[
        for (final thruster in _dragon.thrusters)
          _getThruster(
            context: context,
            thruster: thruster,
            isFirst: _dragon.thrusters.first == thruster,
          ),
      ]),
    );
  }

  Widget _getThruster({BuildContext context, Thruster thruster, bool isFirst}) {
    return RowLayout(children: <Widget>[
      if (!isFirst) Separator.divider(),
      RowItem.text(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.model',
        ),
        thruster.model,
      ),
      RowItem.text(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.amount',
        ),
        thruster.getAmount,
      ),
      RowItem.text(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.fuel',
        ),
        thruster.getFuel,
      ),
      RowItem.text(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.oxidizer',
        ),
        thruster.getOxidizer,
      ),
      RowItem.text(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.thrust',
        ),
        thruster.getThrust,
      ),
      RowItem.text(
        FlutterI18n.translate(
          context,
          'spacex.vehicle.capsule.thruster.isp',
        ),
        thruster.getIsp,
      ),
    ]);
  }
}
