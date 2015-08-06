<?php
namespace Common\Controller;
use Think\Controller;
class HomeBaseController extends Controller {
    public function _initialize() {
        //加载Home配置
        $this->initConfig();
    }

    //加载动态配置
    private function initConfig(){
        $home_config = F('HomeConfig');
        if(!$home_config){
            $home_config=D('Admin/Config')->getConfig('Home');
            F('HomeConfig',$home_config);
        }

        //模板样式
        $home_config['TMPL_PARSE_STRING']=array(
            '__THEME__' => __ROOT__.'/Public/Home/'.$home_config['DEFAULT_THEME'],
        );
        C($home_config);
    }


}