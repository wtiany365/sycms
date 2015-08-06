<?php
namespace Home\Controller;
use Common\Controller\HomeBaseController;

//栏目详情页
class SearchController extends HomeBaseController {
    //文章内页
    public function index() {
        $keywords=I('get.key','');
        if(!$keywords) $this->error('关键词不能为空');
        $this->assign('key',$keywords);

        $count=M('Article')->where('status=1 AND title like \'%'.$keywords.'%\'')->count();
        $Page =new \Lib\Page($count,6);
        $Page->url='search/key/'.$keywords;
        $page =$Page->show();
        $this->assign('page',$page);

        $list_search=M('article a')
            ->join('__CATEGORY__ c ON a.cid=c.id')
            ->where('a.status=1 AND a.title like \'%'.$keywords.'%\'')
            ->field('a.id,a.cid,a.thumb,a.title,a.keywords,a.description,a.add_time,a.view,c.title as cate_title,c.name as cate_name')
            ->limit('0,6')
            ->limit($Page->firstRow.','.$Page->listRows)
            ->order('a.id DESC')
            ->select();

        $this->assign('list_search',$list_search);
        $this->display();
    }

    public function month(){
        $date=I('get.month','');
        if(!$date) $this->error('月份不能为空');
        $this->assign('date',$date);

        $count=M('Article')->where('status=1 AND DATE_FORMAT(add_time,\'%Y-%m\')=\''.$date.'\'')->count();

        $Page =new \Lib\Page($count,6);
        $Page->url='search/month/'.$date;
        $page =$Page->show();
        $this->assign('page',$page);

        $list_search=M('article a')
            ->join('__CATEGORY__ c ON a.cid=c.id')
            ->where('a.status=1 AND DATE_FORMAT(add_time,\'%Y-%m\')=\''.$date.'\'')
            ->field('a.id,a.cid,a.thumb,a.title,a.keywords,a.description,a.add_time,a.view,c.title as cate_title,c.name as cate_name')
            ->limit('0,6')
            ->limit($Page->firstRow.','.$Page->listRows)
            ->order('a.id DESC')
            ->select();

        $this->assign('list_search',$list_search);
        $this->display();
    }

    public function tag(){
        $tag=I('get.tag','');
        if(!$tag) $this->error('标签不能为空');
        $this->assign('tag',$tag);

        //增加标签点击量
        M('Tag')->where("id={$tag}")->setInc('views');

        $count=M('Article')->where('status=1 AND FIND_IN_SET('.$tag.',tag)')->count();
        $Page =new \Lib\Page($count,6);
        $Page->url='search/tag/'.$date;
        $page =$Page->show();
        $this->assign('page',$page);

        $list_search=M('article a')
            ->join('__CATEGORY__ c ON a.cid=c.id')
            ->where('a.status=1 AND FIND_IN_SET('.$tag.',a.tag)')
            ->field('a.id,a.cid,a.thumb,a.title,a.keywords,a.description,a.add_time,a.view,c.title as cate_title,c.name as cate_name')
            ->limit('0,6')
            ->limit($Page->firstRow.','.$Page->listRows)
            ->order('a.id DESC')
            ->select();

        $this->assign('list_search',$list_search);
        $this->display();
    }
    	
}
