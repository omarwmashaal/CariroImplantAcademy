// Mocks generated by Mockito 5.4.2 from annotations
// in cariro_implant_academy/test/core/checkLoginStatus_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i10;

import 'package:cariro_implant_academy/core/data/dataSources/loginStatusDataSource.dart'
    as _i9;
import 'package:cariro_implant_academy/core/domain/repositories/loginStatusRepo.dart'
    as _i5;
import 'package:cariro_implant_academy/core/error/failure.dart' as _i7;
import 'package:cariro_implant_academy/core/features/authentication/data/models/AuthenticationUserModel.dart'
    as _i3;
import 'package:cariro_implant_academy/core/features/authentication/domain/entities/authenticationUserEntity.dart'
    as _i8;
import 'package:cariro_implant_academy/core/Http/httpRepo.dart' as _i4;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAuthenticationUserModel_1 extends _i1.SmartFake
    implements _i3.AuthenticationUserModel {
  _FakeAuthenticationUserModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStandardHttpResponse_2 extends _i1.SmartFake
    implements _i4.StandardHttpResponse {
  _FakeStandardHttpResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CheckLoginStatusRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockCheckLoginStatusRepo extends _i1.Mock
    implements _i5.CheckLoginStatusRepo {
  MockCheckLoginStatusRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i8.AuthenticationUserEntity>>
      checkLoginStatus() => (super.noSuchMethod(
            Invocation.method(
              #checkLoginStatus,
              [],
            ),
            returnValue: _i6.Future<
                    _i2
                    .Either<_i7.Failure, _i8.AuthenticationUserEntity>>.value(
                _FakeEither_0<_i7.Failure, _i8.AuthenticationUserEntity>(
              this,
              Invocation.method(
                #checkLoginStatus,
                [],
              ),
            )),
          ) as _i6
              .Future<_i2.Either<_i7.Failure, _i8.AuthenticationUserEntity>>);
}

/// A class which mocks [LoginStatusDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginStatusDataSource extends _i1.Mock
    implements _i9.LoginStatusDataSource {
  MockLoginStatusDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.AuthenticationUserModel> checkLoginStatus() =>
      (super.noSuchMethod(
        Invocation.method(
          #checkLoginStatus,
          [],
        ),
        returnValue: _i6.Future<_i3.AuthenticationUserModel>.value(
            _FakeAuthenticationUserModel_1(
          this,
          Invocation.method(
            #checkLoginStatus,
            [],
          ),
        )),
      ) as _i6.Future<_i3.AuthenticationUserModel>);
}

/// A class which mocks [HttpRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpRepo extends _i1.Mock implements _i4.HttpRepo {
  MockHttpRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.StandardHttpResponse> get({required String? host}) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
          {#host: host},
        ),
        returnValue: _i6.Future<_i4.StandardHttpResponse>.value(
            _FakeStandardHttpResponse_2(
          this,
          Invocation.method(
            #get,
            [],
            {#host: host},
          ),
        )),
      ) as _i6.Future<_i4.StandardHttpResponse>);
  @override
  _i6.Future<_i4.StandardHttpResponse> post({
    required String? host,
    dynamic body,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [],
          {
            #host: host,
            #body: body,
          },
        ),
        returnValue: _i6.Future<_i4.StandardHttpResponse>.value(
            _FakeStandardHttpResponse_2(
          this,
          Invocation.method(
            #post,
            [],
            {
              #host: host,
              #body: body,
            },
          ),
        )),
      ) as _i6.Future<_i4.StandardHttpResponse>);
  @override
  _i6.Future<_i4.StandardHttpResponse> put({
    required String? host,
    dynamic body,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [],
          {
            #host: host,
            #body: body,
          },
        ),
        returnValue: _i6.Future<_i4.StandardHttpResponse>.value(
            _FakeStandardHttpResponse_2(
          this,
          Invocation.method(
            #put,
            [],
            {
              #host: host,
              #body: body,
            },
          ),
        )),
      ) as _i6.Future<_i4.StandardHttpResponse>);
  @override
  _i6.Future<_i4.StandardHttpResponse> delete({
    required String? host,
    dynamic body,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {
            #host: host,
            #body: body,
          },
        ),
        returnValue: _i6.Future<_i4.StandardHttpResponse>.value(
            _FakeStandardHttpResponse_2(
          this,
          Invocation.method(
            #delete,
            [],
            {
              #host: host,
              #body: body,
            },
          ),
        )),
      ) as _i6.Future<_i4.StandardHttpResponse>);
  @override
  _i6.Future<_i4.StandardHttpResponse> uploadImage({
    required String? url,
    required _i10.Uint8List? imageBytes,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadImage,
          [],
          {
            #url: url,
            #imageBytes: imageBytes,
          },
        ),
        returnValue: _i6.Future<_i4.StandardHttpResponse>.value(
            _FakeStandardHttpResponse_2(
          this,
          Invocation.method(
            #uploadImage,
            [],
            {
              #url: url,
              #imageBytes: imageBytes,
            },
          ),
        )),
      ) as _i6.Future<_i4.StandardHttpResponse>);
}
