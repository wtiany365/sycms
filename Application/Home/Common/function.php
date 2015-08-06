<?php
function nav_line($cid){
	$nav_line=D('Category')->getNavLine($cid);
	return $nav_line;
}

function channel($cid=0){
	$nav_line=D('Category')->getChannel($cid);
	return $nav_line;
}

function cate_data($cid){
	$cate=M('category')
		->field('title,name,is_menu')
		->where("id={$cid}")
		->find();
	$cate['url']=U('/'.$cate['name']);
	return $cate;
}

function list_data($cid,$limit,$type="new"){
	$cate=M('category c')
		->field('c.name,c.is_menu,m.model_table')
		->join('LEFT JOIN __MODEL__ m ON m.id=c.mid')
		->where("c.id={$cid}")
		->find();
	$model=M($cate['model_table']);

	if($cate['is_menu']){
		$ids=M('Category')->where("pid={$cid}")->getField('id',true);
		$map['cid']=array('IN',$ids);
	}else{
		$map['cid']=$cid;
	}
	$map['status']=1;

	switch ($type) {
		case 'new':
			$order='id DESC';
			break;
		case 'hot':
			$order='view DESC';
			break;
	}
	$list=$model->where($map)->limit($limit)->order($order)->select();

	foreach ($list as &$v) {
		$v['url']=U('/'.$cate['name'].'/'.$v['id']);
		$v['thumb']=__ROOT__.$v['thumb'];
	}

	return $list;
}

function value_nav($groups=1,$limit=10){
    //轮播图
    $result=M('Nav')->where("groups={$groups}")->limit($limit)->getField('id,title,url,remark,image');
    return $result;
}

//用于返回data数据表中的资料
function value_data($name=''){
	if(empty($name)) return '';
	$value_data=F('ValueData');
	if(!$value_data){
		$value_data=M('Data')->getField('name,value',true);
		F('ValueData',$value_data);
	}
	if(isset($value_data[$name])) return $value_data[$name];
	else return '';
}

function value_tag($tag=''){
	if(empty($tag)) return '';
	$value_tag=F('ValueTag');
	if(!$value_tag){
		$value_tag=M('Tag')->getField('id,title',true);
		F('ValueTag',$value_tag);
	}
	$result='';
	if(strpos($tag,',') !== false){
		$tags=explode(',', $tag);
		foreach ($tags as $v) {
			isset($value_tag[$v]) && $result.='<a href="'.U('/search',array('tag'=>$v)).'">'.$value_tag[$v].'</a>';
		}
	}else{
		isset($value_tag[$tag]) && $result.='<a href="'.U('/search',array('tag'=>$tag)).'">'.$value_tag[$tag].'</a>';
	}
	return $result;
}