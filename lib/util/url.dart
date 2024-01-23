import 'dart:convert';

dynamic headersApi = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json'
};
final encondingApi = Encoding.getByName('utf-8');

const url_base = "http://66.240.205.86:3011";

const url_login_user = "${url_base}/login_user";
const url_login_client = "${url_base}/login_client";

const url_install_all_pen = "${url_base}/install_pen_all";

const url_fail_all_pen = "${url_base}/fail_all_pen";
