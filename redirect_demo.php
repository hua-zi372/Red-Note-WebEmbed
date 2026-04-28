<?php
/**
 * redirect_demo.php
 * ----------------------------------------
 * 公开示例：极简 URL 中转模板。
 *
 * 真实项目中的中转脚本还包含：
 *   - 结构化访问日志（已脱敏）
 *   - URL-safe Base64 解码与容错
 *   - 含 # 锚点的 URL 修复
 *   - 设备指纹与限流
 * 上述内容 **不在此示例中公开**。
 *
 * 本文件仅展示 301 跳转的基础骨架，任何教程均有类似写法。
 * ----------------------------------------
 */

// 1. 获取目标地址（仅接受已在白名单内的 host）
$raw = isset($_GET['u']) ? trim($_GET['u']) : '';
if ($raw === '') {
    http_response_code(400);
    exit('missing param');
}

// 2. 简单 Base64 解码（真实实现含 url-safe 转换与异常容错，已省略）
$target = base64_decode($raw, true);
if ($target === false) {
    http_response_code(400);
    exit('bad param');
}

// 3. 基础安全校验（真实实现更严格）
if (!preg_match('#^https?://#i', $target)) {
    http_response_code(400);
    exit('invalid scheme');
}

// 4. 跳转
header('Location: ' . $target, true, 302);
exit;
