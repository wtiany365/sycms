<?php
namespace Api\Controller;
use Think\Controller;
class CronController extends Controller {
    public function _initialize(){
        if(!defined('WINCRON')) die;
    }
    public function index(){
        $str= 'api money recharge-'.date('Y-m-d H:i:s');
        F('Yun_'.date('His'),$str);
        var_dump(IS_CLI);
        echo 'ok';
    }
    public function setFile(){
        $str= 'api money recharge-'.date('Y-m-d H:i:s');
        F('Yun_'.date('His'),$str);
        var_dump(IS_CLI);
        echo 'ok';
    }
}