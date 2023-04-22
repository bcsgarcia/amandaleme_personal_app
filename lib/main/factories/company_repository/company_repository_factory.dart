import 'package:company_repository/company_repository.dart';

import '../factories.dart';

CompanyRepository makeCompanyRepositoryFactory() => RemoteCompanyRepository(
      client: makeHttpAdapter(),
      url: makeApiUrlDEV('company/screen/get-meet-app'),
    );
