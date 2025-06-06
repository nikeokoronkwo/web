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

import 'geometry.dart';
import 'html.dart';

/// The **`PaintRenderingContext2D`** interface of the
/// [CSS Painting API](https://developer.mozilla.org/en-US/docs/Web/API/CSS_Painting_API)
/// is the API's rendering context for drawing to the bitmap. It implements a
/// subset of the [CanvasRenderingContext2D] API, with the following exceptions:
///
/// - It doesn't implement the
///   [`CanvasImageData` pixel manipulation](https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D#pixel_manipulation),
///   [`CanvasUserInterface` focus](https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/drawFocusIfNeeded),
///   [`CanvasText` text drawing](https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D),
///   or
///   [`CanvasTextDrawingStyles` text style](https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D#text_styles)
///   interface methods.
/// - The output bitmap is the size of the object it is rendering to.
/// - The value `currentColor`, when used as a color, is treated as opaque
///   black.
///
/// The interface is only available in [PaintWorkletGlobalScope].
///
/// ---
///
/// API documentation sourced from
/// [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/API/PaintRenderingContext2D).
extension type PaintRenderingContext2D._(JSObject _) implements JSObject {
  external void save();
  external void restore();
  external void scale(
    num x,
    num y,
  );
  external void rotate(num angle);
  external void translate(
    num x,
    num y,
  );
  external void transform(
    num a,
    num b,
    num c,
    num d,
    num e,
    num f,
  );
  external DOMMatrix getTransform();
  external void setTransform([
    JSAny aOrTransform,
    num b,
    num c,
    num d,
    num e,
    num f,
  ]);
  external void resetTransform();
  external CanvasGradient createLinearGradient(
    num x0,
    num y0,
    num x1,
    num y1,
  );
  external CanvasGradient createRadialGradient(
    num x0,
    num y0,
    num r0,
    num x1,
    num y1,
    num r1,
  );
  external CanvasPattern? createPattern(
    CanvasImageSource image,
    String repetition,
  );
  external void clearRect(
    num x,
    num y,
    num w,
    num h,
  );
  external void fillRect(
    num x,
    num y,
    num w,
    num h,
  );
  external void strokeRect(
    num x,
    num y,
    num w,
    num h,
  );
  external void beginPath();
  external void fill([
    JSAny fillRuleOrPath,
    CanvasFillRule fillRule,
  ]);
  external void stroke([Path2D path]);
  external void clip([
    JSAny fillRuleOrPath,
    CanvasFillRule fillRule,
  ]);
  external bool isPointInPath(
    JSAny pathOrX,
    num xOrY, [
    JSAny fillRuleOrY,
    CanvasFillRule fillRule,
  ]);
  external bool isPointInStroke(
    JSAny pathOrX,
    num xOrY, [
    num y,
  ]);
  external void drawImage(
    CanvasImageSource image,
    num dxOrSx,
    num dyOrSy, [
    num dwOrSw,
    num dhOrSh,
    num dx,
    num dy,
    num dw,
    num dh,
  ]);
  external void setLineDash(JSArray<JSNumber> segments);
  external JSArray<JSNumber> getLineDash();
  external double get globalAlpha;
  external set globalAlpha(num value);
  external String get globalCompositeOperation;
  external set globalCompositeOperation(String value);
  external bool get imageSmoothingEnabled;
  external set imageSmoothingEnabled(bool value);
  external ImageSmoothingQuality get imageSmoothingQuality;
  external set imageSmoothingQuality(ImageSmoothingQuality value);
  external JSAny get strokeStyle;
  external set strokeStyle(JSAny value);
  external JSAny get fillStyle;
  external set fillStyle(JSAny value);
  external double get shadowOffsetX;
  external set shadowOffsetX(num value);
  external double get shadowOffsetY;
  external set shadowOffsetY(num value);
  external double get shadowBlur;
  external set shadowBlur(num value);
  external String get shadowColor;
  external set shadowColor(String value);
  external double get lineWidth;
  external set lineWidth(num value);
  external CanvasLineCap get lineCap;
  external set lineCap(CanvasLineCap value);
  external CanvasLineJoin get lineJoin;
  external set lineJoin(CanvasLineJoin value);
  external double get miterLimit;
  external set miterLimit(num value);
  external double get lineDashOffset;
  external set lineDashOffset(num value);
}

/// The **`PaintSize`** interface of the
/// [CSS Painting API](https://developer.mozilla.org/en-US/docs/Web/API/CSS_Painting_API)
/// represents the size of the output bitmap that the author should draw.
///
/// ---
///
/// API documentation sourced from
/// [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/API/PaintSize).
extension type PaintSize._(JSObject _) implements JSObject {
  /// The **`width`** read-only property of the [PaintSize] interface returns
  /// the width of the output bitmap that the author should draw.
  external double get width;

  /// The **`height`** read-only property of the [PaintSize] interface returns
  /// the height of the output bitmap that the author should draw.
  external double get height;
}
