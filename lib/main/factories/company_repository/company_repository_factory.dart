import 'package:company_repository/company_repository.dart';
import 'package:http_adapter/http_adapter.dart';

import '../factories.dart';

CompanyRepository makeCompanyRepositoryFactory(String id) => RemoteCompanyRepository(
      client: makeHttpAdapter(),
      url: makeApiUrlDEV('${Environment.getMeetAppPath}/$id'),
    );
