import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: AdditionalProperties(
    pubName: 'gowild_api',
    pubAuthor: 'Convrtx',
  ),
  inputSpecFile: 'https://gowild-api-dev.herokuapp.com/docs-json',
  generatorName: Generator.dio,
  outputDirectory: 'api/gowild_api',
  overwriteExistingFiles: true,
)
class OpenApi extends OpenapiGeneratorConfig {}
