// ignore: import_of_legacy_library_into_null_safe
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'config.dart';
import 'package:veegil_test/api/classes.dart';

part 'api.g.dart';

@RestApi(baseUrl: ROOT_URL)
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(SUMMARY_ENDPOINT)
  Future<HttpResponse<Summary>> getSummary();

  @GET(USERS_ENDPOINT)
  Future<HttpResponse<UsersResult>> getUsers(@Query("q") String? search);

  @GET(TRANSACTIONS_ENDPOINT)
  Future<HttpResponse<TransactionsResult>> getTransactions(
      @Query("limit") int? limit,
      @Query("orderBy") String? orderBy,
      @Query("order") String? order);

  // @GET("/top-headlines?country={country}&apiKey=$NEWS_API_KEY")

  @GET(TRANSACTION_ENDPOINT)
  Future<HttpResponse<TransactionResult>> getTransaction(
      @Query("accountNumber") String accountNumber,
      @Query("deposit") String deposit);

  @GET(WITHDRAWAL_ENDPOINT)
  Future<HttpResponse<TransactionResult>> getWithdrawal(
      @Query("accountNumber") String accountNumber);

  @GET("$USER_ENDPOINT/{accountNumber}")
  Future<HttpResponse<UserResult>> getUser(
      @Path("accountNumber") String accountNumber);

  // @FormUrlEncoded()
  // @GET(TRANSACTION_ENDPOINT)
  // Future<HttpResponse<TransactionResult>> getTransaction(
  //     @Field('accountNumber') String accountNumber);

  @POST(LOGIN_ENDPOINT)
  Future<HttpResponse<LoginResult>> loginUser(@Body() AuthUser authUser);

  @POST(SIGN_UP_ENDPOINT)
  Future<HttpResponse<SignUpResult>> signUpUser(@Body() RegParam regParam);

  @POST(WITHDRAW_ENDPOINT)
  Future<HttpResponse<TransferResult>> withdraw(@Body() DepositParam param);

  @POST(TRANSFER_ENDPOINT)
  Future<HttpResponse<TransferResult>> transfer(@Body() PayParam payParam);

  @POST(DEPOSIT_ENDPOINT)
  Future<HttpResponse<TransferResult>> deposit(@Body() DepositParam param);
}
