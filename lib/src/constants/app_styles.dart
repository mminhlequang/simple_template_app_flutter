import 'package:app/src/constants/constants.dart';
import 'package:internal_core/internal_core.dart';
import 'package:app/src/utils/utils.dart';

double get horizPadding => appContext.width > 720 ? 24.sw : 16.sw;

int get crossAxisCount => appContext.width > 1400
    ? 5
    : appContext.width > 1024
        ? 4
        : appContext.width > 720
            ? 3
            : 2;

int get shimmerItemCount => crossAxisCount * 3;

int get limitItemFetch => crossAxisCount * 6;
