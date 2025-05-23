// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//
// API docs from [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web).
// Attributions and copyright licensing by Mozilla Contributors is licensed
// under [CC-BY-SA 2.5](https://creativecommons.org/licenses/by-sa/2.5/.

// Generated from Web IDL definitions.

// ignore_for_file: unintended_html_in_doc_comment

@JS()
library;

import 'dart:js_interop';

import 'dom.dart';
import 'html.dart';

typedef PaymentShippingType = String;
typedef PaymentComplete = String;

/// The [Payment Request
/// API's](https://developer.mozilla.org/en-US/docs/Web/API/Payment_Request_API)
/// **`PaymentRequest`** interface is the primary access point into the API, and
/// lets web content and apps accept payments from the end user on behalf of the
/// operator of the site or the publisher of the app.
///
/// ---
///
/// API documentation sourced from
/// [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/API/PaymentRequest).
extension type PaymentRequest._(JSObject _) implements EventTarget, JSObject {
  external factory PaymentRequest(
    JSArray<PaymentMethodData> methodData,
    PaymentDetailsInit details, [
    PaymentOptions options,
  ]);

  /// The **[PaymentRequest]** interface's
  /// **`show()`** method instructs the user agent to begin the
  /// process of showing and handling the user interface for the payment request
  /// to the
  /// user.
  ///
  /// Only one payment request can be in the process of being handled at once,
  /// across all
  /// documents. Once one `PaymentRequest`'s `show()` method has been
  /// called, any other call to `show()` will by rejected with an
  /// `AbortError` until the returned promise has been concluded, either by
  /// being
  /// fulfilled with a [PaymentResponse] indicating the results of the payment
  /// request, or by being rejected with an error.
  ///
  /// > [!NOTE]
  /// > In reality, despite the fact that the specification says this
  /// > can't be done, some browsers, including Firefox, support multiple active
  /// > payment
  /// > requests at a time.
  ///
  /// If your architecture doesn't necessarily have all of the data ready to go
  /// at the moment
  /// it instantiates the payment interface by calling `show()`, specify the
  /// `detailsPromise` parameter, providing a `Promise` that is
  /// fulfilled once the data is ready. If this is provided, `show()` will not
  /// allow the user to interact with the payment interface until the promise is
  /// fulfilled, so
  /// that data can be updated prior to the user engaging with the payment
  /// process.
  ///
  /// Processing the result and, if necessary, calling [PaymentResponse.retry]
  /// to retry a failed payment can all be done either asynchronously or
  /// synchronously,
  /// depending on your needs. For the best user experience, asynchronous
  /// solutions are
  /// typically the best way to go. Most examples on MDN and elsewhere use
  /// [`async`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)/[`await`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/await)
  /// to wait asynchronously while results are validated and so forth.
  external JSPromise<PaymentResponse> show(
      [JSPromise<PaymentDetailsUpdate> detailsPromise]);

  /// The `PaymentRequest.abort()` method of the [PaymentRequest]
  /// interface causes the user agent to end the payment request and to remove
  /// any user
  /// interface that might be shown.
  external JSPromise<JSAny?> abort();

  /// The [PaymentRequest] method
  /// **`canMakePayment()`** determines whether or not the request
  /// is configured in a way that is compatible with at least one payment method
  /// supported
  /// by the .
  ///
  /// You can call this before calling
  /// [PaymentRequest.show] to provide a streamlined user experience
  /// when the user's browser can't handle any of the payment methods you
  /// accept.
  ///
  /// For instance, you might call `canMakePayment()` to determine if the
  /// browser
  /// will let the user pay using Payment Request API, and if it won't, you
  /// could fall back to
  /// another payment method, or offer a list of methods that aren't handled by
  /// Payment
  /// Request API (or even provide instructions for paying by mail or by phone).
  external JSPromise<JSBoolean> canMakePayment();

  /// The **`id`** read-only attribute of the
  /// [PaymentRequest] interface returns a unique identifier for a particular
  /// [PaymentRequest] instance.
  ///
  /// When constructing an instance of the [PaymentRequest], you are able to
  /// supply an custom id. If none is provided, the browser automatically sets
  /// the id value to a UUID.
  external String get id;
  external EventHandler get onpaymentmethodchange;
  external set onpaymentmethodchange(EventHandler value);
}
extension type PaymentMethodData._(JSObject _) implements JSObject {
  external factory PaymentMethodData({
    required String supportedMethods,
    JSObject data,
  });

  external String get supportedMethods;
  external set supportedMethods(String value);
  external JSObject get data;
  external set data(JSObject value);
}
extension type PaymentCurrencyAmount._(JSObject _) implements JSObject {
  external factory PaymentCurrencyAmount({
    required String currency,
    required String value,
  });

  external String get currency;
  external set currency(String value);
  external String get value;
  external set value(String value);
}
extension type PaymentDetailsBase._(JSObject _) implements JSObject {
  external factory PaymentDetailsBase({
    JSArray<PaymentItem> displayItems,
    JSArray<PaymentShippingOption> shippingOptions,
    JSArray<PaymentDetailsModifier> modifiers,
  });

  external JSArray<PaymentItem> get displayItems;
  external set displayItems(JSArray<PaymentItem> value);
  external JSArray<PaymentShippingOption> get shippingOptions;
  external set shippingOptions(JSArray<PaymentShippingOption> value);
  external JSArray<PaymentDetailsModifier> get modifiers;
  external set modifiers(JSArray<PaymentDetailsModifier> value);
}
extension type PaymentDetailsInit._(JSObject _)
    implements PaymentDetailsBase, JSObject {
  external factory PaymentDetailsInit({
    JSArray<PaymentItem> displayItems,
    JSArray<PaymentShippingOption> shippingOptions,
    JSArray<PaymentDetailsModifier> modifiers,
    String id,
    required PaymentItem total,
  });

  external String get id;
  external set id(String value);
  external PaymentItem get total;
  external set total(PaymentItem value);
}
extension type PaymentDetailsUpdate._(JSObject _)
    implements PaymentDetailsBase, JSObject {
  external factory PaymentDetailsUpdate({
    JSArray<PaymentItem> displayItems,
    JSArray<PaymentShippingOption> shippingOptions,
    JSArray<PaymentDetailsModifier> modifiers,
    String error,
    PaymentItem total,
    AddressErrors shippingAddressErrors,
    PayerErrors payerErrors,
    JSObject paymentMethodErrors,
  });

  external String get error;
  external set error(String value);
  external PaymentItem get total;
  external set total(PaymentItem value);
  external AddressErrors get shippingAddressErrors;
  external set shippingAddressErrors(AddressErrors value);
  external PayerErrors get payerErrors;
  external set payerErrors(PayerErrors value);
  external JSObject get paymentMethodErrors;
  external set paymentMethodErrors(JSObject value);
}
extension type PaymentDetailsModifier._(JSObject _) implements JSObject {
  external factory PaymentDetailsModifier({
    required String supportedMethods,
    PaymentItem total,
    JSArray<PaymentItem> additionalDisplayItems,
    JSObject data,
  });

  external String get supportedMethods;
  external set supportedMethods(String value);
  external PaymentItem get total;
  external set total(PaymentItem value);
  external JSArray<PaymentItem> get additionalDisplayItems;
  external set additionalDisplayItems(JSArray<PaymentItem> value);
  external JSObject get data;
  external set data(JSObject value);
}
extension type PaymentOptions._(JSObject _) implements JSObject {
  external factory PaymentOptions({
    bool requestPayerName,
    bool requestBillingAddress,
    bool requestPayerEmail,
    bool requestPayerPhone,
    bool requestShipping,
    PaymentShippingType shippingType,
  });

  external bool get requestPayerName;
  external set requestPayerName(bool value);
  external bool get requestBillingAddress;
  external set requestBillingAddress(bool value);
  external bool get requestPayerEmail;
  external set requestPayerEmail(bool value);
  external bool get requestPayerPhone;
  external set requestPayerPhone(bool value);
  external bool get requestShipping;
  external set requestShipping(bool value);
  external PaymentShippingType get shippingType;
  external set shippingType(PaymentShippingType value);
}
extension type PaymentItem._(JSObject _) implements JSObject {
  external factory PaymentItem({
    required String label,
    required PaymentCurrencyAmount amount,
    bool pending,
  });

  external String get label;
  external set label(String value);
  external PaymentCurrencyAmount get amount;
  external set amount(PaymentCurrencyAmount value);
  external bool get pending;
  external set pending(bool value);
}
extension type PaymentCompleteDetails._(JSObject _) implements JSObject {
  external factory PaymentCompleteDetails({JSObject? data});

  external JSObject? get data;
  external set data(JSObject? value);
}
extension type PaymentShippingOption._(JSObject _) implements JSObject {
  external factory PaymentShippingOption({
    required String id,
    required String label,
    required PaymentCurrencyAmount amount,
    bool selected,
  });

  external String get id;
  external set id(String value);
  external String get label;
  external set label(String value);
  external PaymentCurrencyAmount get amount;
  external set amount(PaymentCurrencyAmount value);
  external bool get selected;
  external set selected(bool value);
}

/// The **`PaymentResponse`** interface of the
/// [Payment Request API](https://developer.mozilla.org/en-US/docs/Web/API/Payment_Request_API)
/// is returned after a user selects a payment method and approves a payment
/// request.
///
/// ---
///
/// API documentation sourced from
/// [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/API/PaymentResponse).
extension type PaymentResponse._(JSObject _) implements EventTarget, JSObject {
  /// The **`toJSON()`** method of the [PaymentResponse] interface is a ; it
  /// returns a JSON representation of the [PaymentResponse] object.
  external JSObject toJSON();

  /// The [PaymentRequest] method
  /// **`complete()`** of the
  /// [Payment Request API](https://developer.mozilla.org/en-US/docs/Web/API/Payment_Request_API)
  /// notifies the
  /// that the user interaction is over, and causes any remaining
  /// user interface to be closed.
  ///
  /// This method must be called after the user accepts
  /// the payment request and the `Promise` returned by the
  /// [PaymentRequest.show] method is resolved.
  external JSPromise<JSAny?> complete([
    PaymentComplete result,
    PaymentCompleteDetails details,
  ]);

  /// The [PaymentResponse] interface's
  /// **`retry()`** method makes it possible to ask the user to
  /// retry a payment after an error occurs during processing.
  ///
  /// This lets your app
  /// gracefully deal with situations such as invalid shipping addresses or
  /// declined credit
  /// cards.
  external JSPromise<JSAny?> retry([PaymentValidationErrors errorFields]);

  /// The **`requestId`** read-only property of the
  /// [PaymentResponse] interface returns the free-form identifier supplied by
  /// the `PaymentResponse()` constructor by details.id.
  external String get requestId;

  /// The **`methodName`** read-only
  /// property of the [PaymentResponse] interface returns a string uniquely
  /// identifying the payment handler selected by the user.
  ///
  /// This string may be either
  /// one of the standardized payment method identifiers or a URL used by the
  /// payment handler
  /// to process payments.
  external String get methodName;

  /// The **`details`** read-only property of the
  /// [PaymentResponse] interface returns a JSON-serializable object that
  /// provides a payment method specific message used by the merchant to process
  /// the
  /// transaction and determine a successful funds transfer.
  ///
  /// This data is returned by the payment app that satisfies the payment
  /// request. Developers need to consult whomever controls the URL for the
  /// expected shape of the details object.
  external JSObject get details;

  /// The **`shippingAddress`** read-only property of
  /// the `PaymentRequest` interface returns a [PaymentAddress] object
  /// containing the shipping address provided by the user.
  external JSObject? get shippingAddress;

  /// The **`shippingOption`** read-only property of
  /// the `PaymentRequest` interface returns the ID attribute of the shipping
  /// option selected by the user. This option is only present when the
  /// `requestShipping` option is set to `true` in the
  /// `options` object passed to the
  /// [PaymentRequest.PaymentRequest] constructor.
  external String? get shippingOption;

  /// The **`payerName`** read-only property of the
  /// [PaymentResponse] interface returns the name supplied by the user. This
  /// option is only present when the `requestPayerName` option is set to
  /// `true` in the options parameter of the
  /// [PaymentRequest.PaymentRequest] constructor.
  external String? get payerName;

  /// The `payerEmail` read-only property of the [PaymentResponse]
  /// interface returns the email address supplied by the user. This option is
  /// only present
  /// when the `requestPayerEmail` option is set to `true` in the
  /// `options` object passed to the
  /// [PaymentRequest.PaymentRequest] constructor.
  external String? get payerEmail;

  /// The `payerPhone` read-only property of the [PaymentResponse]
  /// interface returns the phone number supplied by the user. This option is
  /// only present
  /// when the `requestPayerPhone` option is set to `true` in the
  /// `options` object passed to the
  /// [PaymentRequest.PaymentRequest] constructor.
  external String? get payerPhone;
  external EventHandler get onpayerdetailchange;
  external set onpayerdetailchange(EventHandler value);
}
extension type PaymentValidationErrors._(JSObject _) implements JSObject {
  external factory PaymentValidationErrors({
    PayerErrors payer,
    AddressErrors shippingAddress,
    String error,
    JSObject paymentMethod,
  });

  external PayerErrors get payer;
  external set payer(PayerErrors value);
  external AddressErrors get shippingAddress;
  external set shippingAddress(AddressErrors value);
  external String get error;
  external set error(String value);
  external JSObject get paymentMethod;
  external set paymentMethod(JSObject value);
}
extension type PayerErrors._(JSObject _) implements JSObject {
  external factory PayerErrors({
    String email,
    String name,
    String phone,
  });

  external String get email;
  external set email(String value);
  external String get name;
  external set name(String value);
  external String get phone;
  external set phone(String value);
}
extension type AddressErrors._(JSObject _) implements JSObject {
  external factory AddressErrors({
    String addressLine,
    String city,
    String country,
    String dependentLocality,
    String organization,
    String phone,
    String postalCode,
    String recipient,
    String region,
    String sortingCode,
  });

  external String get addressLine;
  external set addressLine(String value);
  external String get city;
  external set city(String value);
  external String get country;
  external set country(String value);
  external String get dependentLocality;
  external set dependentLocality(String value);
  external String get organization;
  external set organization(String value);
  external String get phone;
  external set phone(String value);
  external String get postalCode;
  external set postalCode(String value);
  external String get recipient;
  external set recipient(String value);
  external String get region;
  external set region(String value);
  external String get sortingCode;
  external set sortingCode(String value);
}

/// The **`PaymentMethodChangeEvent`** interface of the
/// [Payment Request API](https://developer.mozilla.org/en-US/docs/Web/API/Payment_Request_API)
/// describes the [PaymentRequest.paymentmethodchange_event] event which is
/// fired by some payment handlers when the user switches payment instruments
/// (e.g., a user selects a "store" card to make a purchase while using Apple
/// Pay).
///
/// ---
///
/// API documentation sourced from
/// [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/API/PaymentMethodChangeEvent).
extension type PaymentMethodChangeEvent._(JSObject _)
    implements PaymentRequestUpdateEvent, JSObject {
  external factory PaymentMethodChangeEvent(
    String type, [
    PaymentMethodChangeEventInit eventInitDict,
  ]);

  /// The read-only **`methodName`** property of the [PaymentMethodChangeEvent]
  /// interface is a string which
  /// uniquely identifies the payment handler currently selected by the user.
  /// The
  /// payment handler may be a payment technology, such as Apple Pay or Android
  /// Pay, and each
  /// payment handler may support multiple payment methods; changes to the
  /// payment method
  /// within the payment handler are described by the
  /// `PaymentMethodChangeEvent`.
  external String get methodName;

  /// The read-only **`methodDetails`** property of the
  /// [PaymentMethodChangeEvent] interface is an object
  /// containing any data the payment handler may provide to describe the change
  /// the user
  /// has made to their payment method. The value is `null` if no details
  /// are available.
  external JSObject? get methodDetails;
}
extension type PaymentMethodChangeEventInit._(JSObject _)
    implements PaymentRequestUpdateEventInit, JSObject {
  external factory PaymentMethodChangeEventInit({
    bool bubbles,
    bool cancelable,
    bool composed,
    String methodName,
    JSObject? methodDetails,
  });

  external String get methodName;
  external set methodName(String value);
  external JSObject? get methodDetails;
  external set methodDetails(JSObject? value);
}

/// The **`PaymentRequestUpdateEvent`** interface is used for events sent to a
/// [PaymentRequest] instance when changes are made to shipping-related
/// information for a pending [PaymentRequest]. Those events are:
///
/// - [PaymentRequest.shippingaddresschange_event]
///   - : Dispatched whenever the user changes their shipping address.
/// - [PaymentRequest.shippingoptionchange_event]
///   - : Dispatched whenever the user changes a shipping option.
///
/// ---
///
/// API documentation sourced from
/// [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/API/PaymentRequestUpdateEvent).
extension type PaymentRequestUpdateEvent._(JSObject _)
    implements Event, JSObject {
  external factory PaymentRequestUpdateEvent(
    String type, [
    PaymentRequestUpdateEventInit eventInitDict,
  ]);

  /// The **`updateWith()`** method of the
  /// [PaymentRequestUpdateEvent] interface updates the details of an existing
  /// [PaymentRequest].
  external void updateWith(JSPromise<PaymentDetailsUpdate> detailsPromise);
}
extension type PaymentRequestUpdateEventInit._(JSObject _)
    implements EventInit, JSObject {
  external factory PaymentRequestUpdateEventInit({
    bool bubbles,
    bool cancelable,
    bool composed,
  });
}
