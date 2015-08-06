<?php

return  array(

    /* 00-配置*/
    'SHOW_PAGE_TRACE' =>false,//显示TRACE信息
    'AUTOLOAD_NAMESPACE' => array(
        'Common' => COMMON_PATH,//Common 移动根目录
        'Lib'   => COMMON_PATH . 'Lib',//lib 第三方类库
    ),//注册命名空间


    /* 01-应用设定 */
    'APP_SUB_DOMAIN_DEPLOY' =>  false,   // 是否开启子域名部署
    'APP_SUB_DOMAIN_RULES'  =>  array(
        'www'        => 'Home',
        'user'       => 'User',
    ), // 子域名部署规则
    'MODULE_DENY_LIST'      =>  array('Common','Runtime'),
    'MODULE_ALLOW_LIST'     =>  array('Home','Admin','Mobile','User','Api','Demo'),


    /* 02-Cookie设置 */
    'COOKIE_PREFIX'         =>  'sy_',      // Cookie前缀 避免冲突


    /* 03-默认设定 */
    'DEFAULT_MODULE'        =>  'Home',  // 默认模块

    /* 04-数据库设置 */
    'DB_DEBUG'              =>  false, // 数据库调试模式 开启后可以记录SQL日志
    'DB_FIELDS_CACHE'       =>  true,  // 启用字段缓存

    /* 05-数据缓存设置 */
    'DATA_CACHE_PREFIX'     =>  'sy_',     // 缓存前缀

    /* 06-错误设置 */
    'SHOW_ERROR_MSG'        =>  true,    // 显示错误信息

    /* 07-日志设置 */
    'LOG_RECORD'            =>  false,   // 默认不记录日志

    /* 08-SESSION设置 */
    'SESSION_PREFIX'        =>  'sy_', // session 前缀

    /* 14-综合配置 */
    'HTTP_CACHE_CONTROL'    =>  'no-cache',  // 网页缓存控制 public,private,no-cache,no-store

    'LOAD_EXT_CONFIG' => 'db',//加载扩展配置文件

);
