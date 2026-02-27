/// separate base api and end-points so that in future if some api change then i can easily changed
/// from here no need to go the every service class to change the endpoint and it also beneficial to add new api in this app also

class ApiEndPoints {
  /// here i singleton this class to never make a instance if already exist
  ApiEndPoints._();

  static const BASE_URL = 'https://fakestoreapi.com';

  static const products = '/products';
  static const categories = '/products/categories';
  static const login = '/auth/login';
  static const getProfile = '/users';
}
