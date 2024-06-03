import 'package:axis_assignment/utils/null_mapper.dart';

class PersonImage {
  final double aspectRatio;
  final int height;
  final String filePath;
  final int width;

  PersonImage({
    required this.aspectRatio,
    required this.height,
    required this.filePath,
    required this.width,
  });

  factory PersonImage.fromJson(Map<String, dynamic> json) => PersonImage(
        aspectRatio: json.value<double>("aspect_ratio"),
        height: json.value<int>("height"),
        filePath: json.value<String>("file_path"),
        width: json.value<int>("width"),
      );
}
