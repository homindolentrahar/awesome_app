import 'package:awesome_app/core/api/response/pagination_respone.dart';
import 'package:awesome_app/core/api/response_parser.dart';

class BaseListResponse<T> {
  final int? statusCode;
  final String? message;
  final Map<String, dynamic>? errors;
  final List<T>? data;
  final PaginationResponse? pagination;

  const BaseListResponse({
    this.statusCode,
    this.message,
    this.data,
    this.errors,
    this.pagination,
  });

  factory BaseListResponse.fromJson(Map<String, dynamic> json) =>
      BaseListResponse(
        statusCode: json['statusCode'],
        message: json['message'],
        errors: json['errors'],
        data: json['data'] == null
            ? null
            : (json['data'] as List<dynamic>)
                .map((e) => ResponseParser<T>().fromJson(e))
                .toList(),
        pagination: json['pagination'] == null
            ? null
            : PaginationResponse.fromJson(json['pagination']),
      );

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'message': message,
        'errors': errors,
        'data': data?.map((e) => ResponseParser().toJson(e)).toList(),
        'pagination': pagination?.toJson(),
      };
}
