// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get button_go_favorite {
    return Intl.message(
      'Favorite',
      name: 'button_go_favorite',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get button_go_history {
    return Intl.message(
      'History',
      name: 'button_go_history',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get title_new {
    return Intl.message(
      'New',
      name: 'title_new',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get title_popular {
    return Intl.message(
      'Popular',
      name: 'title_popular',
      desc: '',
      args: [],
    );
  }

  /// `Device`
  String get tab_device {
    return Intl.message(
      'Device',
      name: 'tab_device',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get tab_service {
    return Intl.message(
      'Service',
      name: 'tab_service',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get button_add_to_cart {
    return Intl.message(
      'Add to cart',
      name: 'button_add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Order Info`
  String get title_order_info {
    return Intl.message(
      'Order Info',
      name: 'title_order_info',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get title_sub_total {
    return Intl.message(
      'Subtotal',
      name: 'title_sub_total',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Cost`
  String get title_ship {
    return Intl.message(
      'Shipping Cost',
      name: 'title_ship',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get title_total {
    return Intl.message(
      'Total',
      name: 'title_total',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get button_buy {
    return Intl.message(
      'Buy',
      name: 'button_buy',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get button_add {
    return Intl.message(
      'Add',
      name: 'button_add',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get title_price {
    return Intl.message(
      'Price',
      name: 'title_price',
      desc: '',
      args: [],
    );
  }

  /// `Empty Order`
  String get empty {
    return Intl.message(
      'Empty Order',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Complete your order by filling all infomation`
  String get complete_your_order {
    return Intl.message(
      'Complete your order by filling all infomation',
      name: 'complete_your_order',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Time Oder`
  String get time_order {
    return Intl.message(
      'Time Oder',
      name: 'time_order',
      desc: '',
      args: [],
    );
  }

  /// `Payment methods`
  String get pay_method {
    return Intl.message(
      'Payment methods',
      name: 'pay_method',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash_method {
    return Intl.message(
      'Cash',
      name: 'cash_method',
      desc: '',
      args: [],
    );
  }

  /// `Internet Banking`
  String get atm_method {
    return Intl.message(
      'Internet Banking',
      name: 'atm_method',
      desc: '',
      args: [],
    );
  }

  /// `Empty favorite item`
  String get empty_fav {
    return Intl.message(
      'Empty favorite item',
      name: 'empty_fav',
      desc: '',
      args: [],
    );
  }

  /// `Sorry for the inconvenience, we will update the internet banking method later`
  String get sorry_atm {
    return Intl.message(
      'Sorry for the inconvenience, we will update the internet banking method later',
      name: 'sorry_atm',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get method_home {
    return Intl.message(
      'Home',
      name: 'method_home',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get method_store {
    return Intl.message(
      'Store',
      name: 'method_store',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all fields`
  String get message_field_all {
    return Intl.message(
      'Please fill in all fields',
      name: 'message_field_all',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
