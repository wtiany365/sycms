<?php
namespace Home\Model;
use Think\Model;

class CategoryModel extends Model{

    public function getCategory(){
        $cid=I('cid','','intval');
        $cname = I('cname', '', 'htmlspecialchars,trim');

        if(!empty($cid)) $map['id']=$cid;
        elseif(!empty($cname)) $map['name']=$cname;
        else E('栏目不存在');

        $category=$this->where($map)->find();
        $category['url']=U('/'.$category['name'],'','html',true);
        if(!empty($category['setting'])){
            $setting=unserialize($category['setting']);
            unset($category['setting']);
            $category=array_merge($setting,$category);
        }
        return $category;
    }

    public function getNavLine($cid){
        $category=$this->where('status=1')->getField('id,pid,title,name');
        $nav_line=\Lib\ArrayTree::getParents($category,$cid);
        foreach ($nav_line as &$v) {
            $v['url']=U('/'.$v['name']);
        }
        return $nav_line;
    }



}