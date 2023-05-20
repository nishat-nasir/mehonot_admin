import 'dart:convert';
import 'dart:developer';

logger(var str, {String? hint}) {
  log(hint ?? 'LOGGER');
  log(str.toString());
  log(hint ?? 'LOGGER');
}
