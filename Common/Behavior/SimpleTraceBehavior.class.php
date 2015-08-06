<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2013 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
namespace Common\Behavior;
use Think\Behavior;

class SimpleTraceBehavior extends Behavior {

    // 行为扩展的执行入口必须是run
    public function run(&$params){
        G('beginTime',$GLOBALS['_beginTime']);
        G('viewEndTime');
        $ip = get_client_ip();
        echo '服务器执行: '.G('beginTime','viewEndTime').' 秒 , 数据库查询: '.N('db_query').' 次.';
    }

}