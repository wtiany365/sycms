<?php
namespace Common\Model;
use Think\Model;

class CategoryModel extends Model {

    public function getCache(){
    	$category=F('Category');
    	if(!$category){
	    	$category=$this
	    		->where('status=1')
	    		->order('sort asc')
	    		->getField('id,pid,title,name,mid,is_menu',true);
	    	$model=M('Model')->getField('id,model_table');

			foreach ($category as &$v) {
				$v['url']=U('/'.$v['name'],'','html',true);
				if($v['mid']){
					$v['table']=$model[$v['mid']];
				}else{
					$v['table']=$v['name'];
				}
				unset($v['mid']);
			}

			F('Category',$category);
    	}
		return $category;
    }

    public function delCache(){
    	F('Category',NULL);
    }



}
