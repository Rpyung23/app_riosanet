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

const url_fail_all_pen_client = "${url_base}/fail_all_client";

const url_update_domiclio_client = "${url_base}/transfers_all_client";

const url_delete_fail = "${url_base}/delete_fail";

const url_type_fail = "${url_base}/type_fail";

const url_create_fail = "${url_base}/create_fail";

const url_delete_transfer = "${url_base}/delete_transfers";
