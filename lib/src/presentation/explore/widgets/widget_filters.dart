import 'package:internal_core/internal_core.dart';
import 'package:app/src/constants/constants.dart';
import 'package:app/src/presentation/home/cubit/model_cubit.dart';
import 'package:app/src/presentation/widgets/widgets.dart';
import 'package:app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetFilters extends StatelessWidget {
  const WidgetFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModelCubit, ModelState>(
      bloc: modelCubit,
      builder: (context, state) {
        if (state.tags?.isNotEmpty != true) return const SizedBox();
        return WidgetOverlayActions(
          builder: (child, size, childPosition, pointerPosition, animationValue,
              hide) {
            return Positioned(
              right: context.width - childPosition.dx - 44,
              top: childPosition.dy + size.height + 4,
              child: WidgetPopupContainer(
                alignmentTail: Alignment.topRight,
                borderRadius: BorderRadius.circular(12.sw),
                width: 160.sw,
                height: 260.sw,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.sw),
                  child: SingleChildScrollView(
                    child: Column(
                      children: state.tags!
                          .map((e) => WidgetRippleButton(
                                onTap: AppPrefs.instance.tag == e.name
                                    ? null
                                    : () async {
                                        appHaptic();
                                        AppPrefs.instance.tag = e.name;
                                        modelCubit.fetchModels(refresh: true);
                                        await hide();
                                      },
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.sw, vertical: 8),
                                  child: Opacity(
                                    opacity: AppPrefs.instance.tag == e.name
                                        ? .5
                                        : 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e.name?.capitalizeFirst ?? "",
                                            maxLines: 1,
                                            textAlign: TextAlign.right,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                w500TextStyle(fontSize: 16.sw),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            );
          },
          child: const WidgetFloatIconButton(
            isSmallSize: false,
            icon: 'menu',
            color: Colors.white,
          ),
        );
      },
    );
  }
}
