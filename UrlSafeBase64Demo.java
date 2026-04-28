/*
 * UrlSafeBase64Demo.java
 * ----------------------------------------
 * 公开示例：URL-safe Base64 编解码工具类。
 * 用于客户端与中转服务之间传递 URL 时，避免 '+' '/' '=' 带来的兼容问题。
 * 本文件为通用工具，与本项目核心逻辑无关。
 * ----------------------------------------
 */
package com.example.embed.util;

import android.util.Base64;

public final class UrlSafeBase64Demo {

    private UrlSafeBase64Demo() {}

    /** 将任意字符串以 URL-safe Base64 方式编码，不补 '=' 填充。 */
    public static String encode(String raw) {
        if (raw == null) return "";
        byte[] bytes = raw.getBytes();
        return Base64.encodeToString(bytes,
                Base64.URL_SAFE | Base64.NO_WRAP | Base64.NO_PADDING);
    }

    /** 对 URL-safe Base64 字符串进行解码，失败返回空串。 */
    public static String decode(String encoded) {
        if (encoded == null || encoded.isEmpty()) return "";
        try {
            byte[] bytes = Base64.decode(encoded,
                    Base64.URL_SAFE | Base64.NO_WRAP | Base64.NO_PADDING);
            return new String(bytes);
        } catch (IllegalArgumentException e) {
            return "";
        }
    }
}
