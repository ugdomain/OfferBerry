import '../data/model/response/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Seller OFFER BARRIES';

  static const String BASE_URL = 'https://offerbaries.com';
  static const String CATEGORY = '/api/v2/seller/products/get-raw-categories';
  static const String SUB_CATEGORY =
      '/api/v2/seller/products/get-raw-sub-categories';
  static const String PRODUCT_LIST = '/api/v2/seller/products/get-products';
  static const String LOGIN_URI = '/api/v2/seller/auth/login';
  static const String CONFIG_URI = '/api/v2/seller/config/1';
  static const String SELLER_URI = '/api/v2/seller/seller-info';
  static const String USER_EARNINGS_URI = '/api/v2/seller/monthly-earning';
  static const String SELLER_AND_BANK_UPDATE = '/api/v2/seller/seller-update';
  static const String SHOP_URI = '/api/v2/seller/shop-info';
  static const String SHOP_UPDATE = '/api/v2/seller/shop-update';
  static const String MESSAGE_URI = '/api/v2/seller/messages/list';
  static const String SEND_MESSAGE_URI = '/api/v2/seller/messages/send';
  static const String ORDER_LIST_URI = '/api/v2/seller/orders/list';
  static const String ORDER_DETAILS = '/api/v2/seller/orders/';
  static const String UPDATE_ORDER_STATUS =
      '/api/v2/seller/orders/order-detail-status/';
  static const String ICON_URL = "/storage/app/public/category/store/";
  static const String BALANCE_WITHDRAW = '/api/v2/seller/balance-withdraw';
  static const String CANCEL_BALANCE_REQUEST =
      '/api/v2/seller/close-withdraw-request';
  static const String TRANSACTIONS_URI = '/api/v2/seller/transactions';

  static const String NOTIFICATION_URI = '/api/v2/seller/notifications';
  static const String TOKEN_URI = '/api/v2/seller/cm-firebase-token';

  static const String PENDING = 'pending';
  static const String CONFIRMED = 'confirmed';
  static const String PROCESSING = 'processing';
  static const String PROCESSED = 'processed';
  static const String DELIVERED = 'delivered';
  static const String FAILED = 'failed';
  static const String RETURNED = 'returned';
  static const String CANCELLED = 'cancelled';

  static const String THEME = 'theme';
  static const String CURRENCY = 'currency';
  static const String TOKEN = 'token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_NUMBER = 'user_number';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';
  static const String USER_EMAIL = 'user_email';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.united_kindom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];
}
