<?php
namespace Home\Controller;
use Common\Controller\HomeBaseController;

//栏目列表页
class ListController extends HomeBaseController {
    //文章内页
    public function index() {
        $cate=D('Category')->getCategory();

        $this->assign('CATEGORY',$cate);
        $this->assign('CID',$cate['id']);
        $this->assign('PID',$cate['pid']);

        $tpl=$cate['template_list'];
        $this->display($tpl);
    }

    private function getCateList($cid){
        $cate=M('Category c')
         ->join('__MODEL__ as m ON c.mid=m.id')
         ->field('c.id,c.pid,c.is_menu,c.name,m.model_table')
         ->where("c.id={$cid}")
         ->find();


        $map=array();
        if($cate['is_menu']){
            $cid_arr=M('Category')->where("pid={$cid}")->getField('id',true);
            $cid_str=implode(',', $cid_arr);
            $map['cid']=array('IN',$cid_str);
        }else{
            $map['cid']=array('EQ',$cid);
        }

        $count=M($cate['model_table'])->where($map)->count();
        $Page =new \Lib\Page($count,6);
        $Page->url=$cate['name'];
        $page =$Page->show();
        $this->assign('page',$page);

        //获取当前栏目最新列表
        $map['a.status']=1;
        $list=M($cate['model_table'].' a')
            ->join('__CATEGORY__ c ON a.cid=c.id')
            ->field('a.id,a.cid,a.title,a.keywords,a.thumb,a.description,a.add_time,a.view,c.title as cate_title,c.name as cate_name')
            ->order('a.id DESC')
            ->where($map)
            ->limit($Page->firstRow.','.$Page->listRows)
            ->select();
        $this->assign('list_cate',$list);

        //获取当前栏目热门列表
        $list_hot=M('article a')
            ->join('__CATEGORY__ c ON a.cid=c.id')
            ->where($map)
            ->field('a.id,a.cid,a.title,a.view,c.title as cate_title,c.name as cate_name')
            ->limit('0,6')
            ->order('a.view DESC')
            ->select();
        $this->assign('list_hot',$list_hot);
    }

    private function getCateShow($cid,$mid){

        $table=M('Model')->where("id={$mid}")->getField('model_table');
        $info=M($table)->where("cid={$cid}")->find();
        $this->assign('show',$info);
    }


    	
}
