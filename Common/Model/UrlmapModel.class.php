<?php
namespace Common\Model;
use Think\Model;

class UrlmapModel extends Model{

//获取name对应路由
	public function getRouteRule(){
		$rule=F('RouteRule');
		if(!$rule){
			$where['status']=1;
			$rule=$this->where($where)->getField('route,url',true);
			F('RouteRule',$rule);
		}
		return $rule;
	}

//获取路径对应路由
	public function getRouteUrl(){
		$route_url=F('RouteUrl');
		if(!$route_url){
			$route=$this->getRouteRule();
			foreach ($route as $k => $v){
				//解析URL
				$info   =  parse_url($v);
				//判断是否完整 url
				$arr   =  explode("/",$info['path']);
				if(count($arr)!=3){ continue; }
				//解析参数
				$vars = array();
				if(isset($info['query'])) { // 解析地址里面参数 合并到vars
					parse_str($info['query'],$params);
					$vars = array_merge($params,$vars);
					ksort($vars);
				}
				$route_url[$info['path']][]=array("query"=>$vars,"url"=>$k);
			}
			F('RouteUrl',$route_url);
		}
		return $route_url;
	}

//根据模型ID设置Category的路由URL
	public function getCategoryUrl($model_id,$category_name,$cid){
		switch ($model_id) {
			case 0:
				//独立模型
				$url='home/'.$category_name.'/index';
				break;
			case 2:
				//单页模型
				$url='home/page/index?cid='.$cid;
				break;
			default:
				//文章|图集
				$url='home/list/index?cid='.$cid;
				break;
		}
		return $url;
	}

//重建路由缓存
	protected function _after_insert($data,$options){
		$this->delCache();
	}
	protected function _after_update($data,$options){
		$this->delCache();
	}
	protected function _after_delete($data,$options) {
		$this->delCache();
	}

//清理缓存
	private function delCache(){
		F('RouteRule',NULL);
		F('RouteUrl',NULL);
	}

}