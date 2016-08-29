# 山雨内容管理系统
## 简介
山雨内容管理系统基于THINKPHP 3.2版本制作,实现权限管理,接入短信接口,上传驱动切换(本地/七牛),全局动态参数,后台模版页自动生成(FormBuilder),封装富文本UEDITOR/上传WEBUPLOADER插件/弹出层ARTDIALOG等.

## 示例
``` php
//Widget封装插件调用
内容: {:W('Ueditor/editor',array('content',$info['content']))}
图集: {:W('Uploader/images',array('images',$info['images']))}
```

## 截图
### 动态后台菜单及权限节点
![动态后台菜单及权限节点](http://git.oschina.net/uploads/images/2015/0807/115621_7585be13_10167.jpeg "动态后台菜单及权限节点")
### 栏目分类
![栏目分类](http://git.oschina.net/uploads/images/2015/0807/115802_a57e7c23_10167.jpeg "栏目分类")
### 内容添加
![内容添加](http://git.oschina.net/uploads/images/2015/0807/115929_60dac37b_10167.jpeg "内容添加")
### 上传方式
![上传方式](http://git.oschina.net/uploads/images/2015/0807/120338_e9157b26_10167.jpeg "上传方式")