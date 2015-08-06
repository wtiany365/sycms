<?php
namespace Admin\Model;
use Think\Model;

class AdminMenuModel extends Model{

	public function getNav(){
        $admin_menu=M('AdminMenu a')
            ->join('__AUTH_RULE__ r ON a.rid=r.id')
            ->field('r.id,r.title,r.name,r.icon')
            ->where('a.uid='.UID)
            ->limit('0,9')
            ->select();
        return $admin_menu;
	}

}