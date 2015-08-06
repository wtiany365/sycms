<?php
namespace Home\Controller;
use Common\Controller\HomeBaseController;

//单页
class PageController extends HomeBaseController {
    public function index() {
        $cate=D('Category')->getCategory();
        if($cate['is_menu']){
            $cate=M('Category')->where("pid={$cate['id']}")->order('sort asc')->find();
            $cate['url']=U('/'.$cate['name'],'','html',true);
            if(!empty($cate['setting'])){
                $set=unserialize($cate['setting']);
                unset($cate['setting']);
                $cate=array_merge($set,$cate);
            }
        }

        $this->assign('CATEGORY',$cate);
        $this->assign('CID',$cate['id']);
        $this->assign('PID',$cate['pid']);

        //获取单页内容
        $show=M('Page')->where("cid={$cate['id']}")->find();
        $this->assign('show',$show);

        $tpl=$cate['template_page'];
        $this->display($tpl);
    }
    	
}
