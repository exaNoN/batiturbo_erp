part of 'app_pages.dart';

abstract class Routes {
  static const home = Paths.home;
  static const createJob = Paths.createJob;
  static const customerP = Paths.customerP;
  static const turboP = Paths.turboP;
  static const userP = Paths.userP;
  static const taskP = Paths.taskP;
  static const paymentP = Paths.paymentP;
}

abstract class Paths {
  static const home = '/';
  static const createJob = '/create_job';
  static const customerP = '/customer_page';
  static const turboP = '/turbo_page';
  static const userP = '/user_page';
  static const taskP = '/task_page';
  static const paymentP = '/payment_page';
}
