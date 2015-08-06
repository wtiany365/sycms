<?php
namespace Admin\Controller;
use Common\Controller\AdminBaseController;

class AdminMenuController extends AdminBaseController {

	public function index(){
		//数据
		$list=D('AdminMenu')->getNav();
		$this->assign('list',$list);

		$this->display();
	}

	public function search($keywords=''){
		//数据
		$map['type']=2;
		$map['status']=1;
		$map['title']=array('like','%'.$keywords.'%');
		$list=D('AuthRule')->where($map)->field('id,title,name')->select();
		$this->assign('list',$list);

		$this->display();
	}

	public function add(){
		if(IS_POST){$this->addPost();exit;}
		$rule=M('AuthRule')->where('type=2 AND status=1')->getField('id,title',true);
		$this->assign('rule',$rule);

		$this->display();
	}
	private function addPost(){
		$Model=D('AdminMenu');
		$data=$Model->create();
		if(!$data) $this->error($Model->getError());

		$return=$Model->add($data);
		if($return) $this->success('添加成功');
		else $this->error('添加失败');
	}

	public function edit($id){
		if(IS_POST){$this->editPost();exit;}
		$info=M('AdminMenu')->where('uid='.UID.' AND rid='.$id)->find();
		$this->assign('info',$info);

		$rule=M('AuthRule')->where('type=2 AND status=1')->getField('id,title',true);
		$this->assign('rule',$rule);

		$this->display();
	}
	private function editPost(){
		$Model=D('AdminMenu');
		$data=$Model->create();
		if(!$data) $this->error($Model->getError());

		$return=$Model->save($data);
		if($return) $this->success('修改成功');
		else $this->error('修改失败');
	}

	public function del($id){
		$return=M('AdminMenu')->where('uid='.UID.' AND rid='.$id)->delete();
		if($return) $this->success('删除成功');
		else $this->error('删除失败');
	}








}