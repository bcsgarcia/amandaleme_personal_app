import 'package:http_adapter/http_adapter.dart';
import 'package:repositories/repositories.dart';

import '../factories.dart';

CompanyRepository makeCompanyRepositoryFactory(String id) => RemoteCompanyRepository(
      client: makeHttpAdapter(),
      url: makeApiUrlDEV('${Environment.getMeetAppPath}/$id'),
    );
