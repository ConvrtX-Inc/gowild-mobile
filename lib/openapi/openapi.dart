import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: AdditionalProperties(
    pubName: 'gowild_api',
    pubAuthor: 'Convrtx',
  ),
  inputSpecFile: 'http://localhost:3001/docs-json',
  generatorName: Generator.dio,
  outputDirectory: 'api/gowild_api',
)
class OpenApi extends OpenapiGeneratorConfig {}
