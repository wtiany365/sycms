SET FOREIGN_KEY_CHECKS=0;


DROP TABLE IF EXISTS `sy_admin`;
CREATE TABLE `sy_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` char(20) NOT NULL DEFAULT '' COMMENT '登录名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `encrypt` char(6) NOT NULL,
  `email` char(30) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `mobile` char(11) NOT NULL DEFAULT '0' COMMENT '手机号',
  `realname` char(20) NOT NULL DEFAULT '' COMMENT '真实名称',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `token` char(32) NOT NULL DEFAULT '' COMMENT 'cookie登录记录标识',
  `token_time` int(10) unsigned NOT NULL COMMENT 'cookie记录标识过期时间',
  `session_id` char(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员资料表';


DROP TABLE IF EXISTS `sy_admin_log`;
CREATE TABLE `sy_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作者用户名',
  `log_action` char(20) NOT NULL DEFAULT '0' COMMENT '操作',
  `log_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:成功,1:失败',
  `log_record` varchar(100) NOT NULL COMMENT '操作记录',
  `log_ip` char(15) NOT NULL COMMENT '操作者IP',
  `log_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `deal_user` (`uid`,`log_action`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员操作日志';




DROP TABLE IF EXISTS `sy_admin_menu`;
CREATE TABLE `sy_admin_menu` (
  `uid` smallint(6) NOT NULL,
  `rid` smallint(6) NOT NULL,
  `sort` tinyint(4) NOT NULL,
  `title` varchar(20) NOT NULL,
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员自定义快捷菜单';


INSERT INTO `sy_admin_menu` VALUES ('1', '9', '15', '后台菜单权限管理');
INSERT INTO `sy_admin_menu` VALUES ('1', '50', '0', '站点常用配置管理');
INSERT INTO `sy_admin_menu` VALUES ('1', '46', '0', '内容信息管理');


DROP TABLE IF EXISTS `sy_article`;
CREATE TABLE `sy_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `cid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `title` varchar(60) NOT NULL DEFAULT '' COMMENT '标题',
  `thumb` varchar(150) NOT NULL DEFAULT '' COMMENT '缩略图',
  `content` text NOT NULL COMMENT '内容',
  `tag` varchar(100) NOT NULL,
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(150) NOT NULL DEFAULT '' COMMENT '摘要描述',
  `edit_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  `view` int(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;


INSERT INTO `sy_article` VALUES ('1', '2', 'Js返回上一页:history.go()和history.back()区别', '/Uploads/2015-08-17/55d1b10a1ecb0.jpg', '<p>简单的说就是：go(-1): 返回上一页，原页面表单中的内容会丢失；back(): 返回上一页，原页表表单中的内容会保留。&nbsp;</p><p>history.go(-1):后退+刷新&nbsp;</p><p>history.back():后退&nbsp;</p><p><br/></p><p>之所以注意到这个区别，是因为不同的浏览器的后退行为也是有区别的，而区别就跟Javascript:history.go()和history.back()的区别类似。&nbsp;</p><p><br/></p><p>chrome和ff浏览器后退页面，会刷新后退的页面，若有数据请求也会提交数据申请。类似于 history.go(-1)&nbsp;</p><p><br/></p><p>而safari（包括桌面版和ipad版本）的后退按钮则不会刷新页面，也不会提交数据申请。类似于 Javascript:history.back()</p><p><br/></p><pre class=\"brush:js;\">&lt;a&nbsp;class=&quot;btn&quot;&nbsp;href=&quot;javascript:window.history.back();&quot;&gt;返回&lt;/a&gt;</pre><p><br/></p>', '2', 'history.go,history.back', '简单的说就是：go(-1): 返回上一页，原页面表单中的内容会丢失；back(): 返回上一页，原页表表单中的内容会保留。', '2015-08-17 18:39:04', '2015-01-01 01:00:17', '22', '1');
INSERT INTO `sy_article` VALUES ('2', '4', 'Linux_easyBCD安装双系统步骤', '', '<p>(1)准备两个东西EasyBCD软件和ISO镜像(据说下载1.7之后版就行，要那种安装版的，不要绿色版)</p><p>(2)把准备好的ISO用解压缩软件或者虚拟光驱打开，找到casper文件夹，复制initrd.lz和vmlinuz（或vmlinuz.efi）到某盘根目录,然后在把ISO文件也放到该分区根目录。</p><p>(3)打开EasyBCD软件，可以看到现在我们的计算机启动“入口”情况，</p><p>选择添加新条目（AddNew Entry）</p><p>选NeoGrub然后点安装（Install），接着是配置（Configure），然后就会出现一个menu.lst文件</p><p><br/></p><p>title Install UbuntuKylin</p><p>root (hd0,<span style=\"color: rgb(255, 0, 0);\">0</span>)</p><p>kernel (hd0,<span style=\"color: rgb(255, 0, 0);\">0</span>)/<span style=\"color: rgb(255, 0, 0);\">vmlinuz.efi</span> boot=casper iso-scan/filename=/<span style=\"color: rgb(255, 0, 0);\">ubuntukylin-14.04.2-desktop-amd64.iso</span> ro quiet splash locale=zh_CN.UTF-8</p><p>initrd (hd0,<span style=\"color: rgb(255, 0, 0);\">0</span>)/initrd.lz</p><p><br/></p><p>1.放置ISO文件的分区是磁盘中第几个分区.</p><p>2.32位系统:vmlinuz,64位系统:vmlinuz.efi.</p><p>3.ISO文件文件名称.</p><p><br/></p><p>(4)重启,你就会看到有2个启动菜单给你选择我们选择NeoGrub这个</p><p>(5)进入系统后，打开终端，运行以下命令卸载镜像分区：&nbsp;</p><p><span style=\"color: rgb(255, 0, 0);\">sudo umount -l /isodevice</span></p><p><br/></p><p>分区</p><p>根分区 / 15G ext4</p><p>交换分区 /swap 4G</p><p>启动分区 /boot 150M ext2</p><p>缓存分区 /tmp &nbsp;5G ext4</p><p>用户分区 /home 30G ext4</p>', '', 'linux,easybcd', '(1)准备两个东西EasyBCD软件和ISO镜像(据说下载1.7之后版就行，要那种安装版的，不要绿色版)\r\n(2)把准备好的ISO用解压缩软件或者虚拟光驱打开，找到casper文件夹，复制initrd.lz和vmlinuz（或vmlinuz.efi）到某盘根目录,然后在把ISO文件也放到该分区根目录', '2015-08-17 21:54:19', '2015-08-17 21:50:34', '88', '1');
INSERT INTO `sy_article` VALUES ('3', '4', 'WampServer_常用配置', '/Uploads/2015-08-17/55d1e8260a381.gif', '<p><span style=\"color:#ff0000;font-family:Consolas;font-size:16px;background-color: inherit;\">1.开启伪静态</span></p><p><span style=\"color:#ff0000;font-family:Consolas;font-size:16px;background-color: inherit;\"><span style=\"color: rgb(0, 0, 0);\">修改文件Apache配置文件 bin\\apache\\apache2.2.22\\conf\\httpd.conf</span><br style=\"background-color: inherit;\"/></span></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><span style=\"color: rgb(51, 51, 51);\">(1)开启 LoadModule rewrite_module modules/mod_rewrite.so</span><br style=\"background-color: inherit;\"/></span></p><p><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\"><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\">(2)</span></code></p><p><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\"><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\">&lt;Directory&nbsp;/&gt;</span></code></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: rgb(64, 170, 83);\">&nbsp;&nbsp;&nbsp;&nbsp;</code><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\">Options&nbsp;FollowSymLinks</code></span></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: rgb(64, 170, 83);\">&nbsp;&nbsp;&nbsp;&nbsp;</code><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit;\"><span style=\"color:#ff0000;background-color: inherit;\">AllowOverride&nbsp;None</span></code></span></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: rgb(64, 170, 83);\">&nbsp;&nbsp;&nbsp;&nbsp;</code><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\">Order&nbsp;deny,allow</code></span></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: rgb(64, 170, 83);\">&nbsp;&nbsp;&nbsp;&nbsp;</code><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\">Deny&nbsp;from&nbsp;all</code></span></p><p><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\"><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\">&lt;/Directory&gt;</span></code></p><p><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\"><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\">修改为</span></code></p><p><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\"><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><span style=\"color: rgb(255, 0, 0);\">AllowOverride&nbsp;All</span><br style=\"background-color: inherit;\"/></span></code></p><p><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\"><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><span style=\"color: rgb(255, 0, 0);\"><br style=\"background-color: inherit;\"/></span></span></code></p><p><code style=\"font-family: Monaco, Consolas, Courier, &#39;Lucida Console&#39;, monospace; background-color: inherit; color: black !important;\"><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><span style=\"color: rgb(255, 0, 0);\">2.修改Mysql密码</span></span></code></p><p><span style=\"font-size:16px;background-color: inherit;\"><span style=\"font-family:Consolas;background-color: inherit;\"><span style=\"background-color: inherit; line-height: 24px;\">(1)</span></span><span style=\"font-family: Consolas; line-height: 1.5;\">命令行输：mysql -u root回车进入mysql</span></span></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\">然后输入命令：SET PASSWORD FOR&nbsp;&#39;root&#39;@&#39;localhost&#39;&nbsp;= PASSWORD(&#39;root&#39;);</span></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><span style=\"background-color: inherit; line-height: 24px;\">(2)修改phpmyadmin配置文件&nbsp;apps\\phpmyadmin3.4.10.1\\config.inc.php</span></span></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><br style=\"background-color: inherit;\"/></span></p><p><span style=\"font-size:16px;color:#ff0000;background-color: inherit;\">3.修改www路径</span></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\">修改文件Apache配置文件 bin\\apache\\apache2.2.22\\conf\\httpd.conf</span></p><p><span style=\"font-family:Consolas;font-size:16px;background-color: inherit;\"><span style=\"background-color: inherit; line-height: 24px;\">(1)</span></span><span style=\"font-family: Consolas; font-size: medium; line-height: 1.5;\">DocumentRoot &quot;</span><strong style=\"font-family: Consolas; font-size: medium; line-height: 1.5;\"><span style=\"color:#ff0000;background-color: inherit;\">D:/Wamp Server/www/</span></strong><span style=\"font-family: Consolas; font-size: medium; line-height: 1.5;\">&quot;</span></p><p><span style=\"font-family: Consolas; font-size: medium; line-height: 1.5;\">&lt;Directory &quot;</span><span style=\"color:#ff0000;font-family: Consolas; font-size: medium; line-height: 1.5;\">D:/Wamp Server/www/</span><span style=\"font-family: Consolas; font-size: medium; line-height: 1.5;\">&quot;&gt;</span></p><p><span style=\"font-family: Consolas; font-size: medium; line-height: 1.5;\">修改为</span></p><p><span style=\"font-family: Consolas; font-size: medium; line-height: 1.5;\"><span style=\"color:#ff0000;background-color: inherit;\">D:/www/</span></span></p><p><span style=\"font-family: Consolas; font-size: medium; line-height: 1.5;\"><span style=\"color:#ff0000;background-color: inherit;\"><br style=\"background-color: inherit;\"/></span></span></p><p><span style=\"font-family: Consolas; font-size: medium; line-height: 1.5;\"><span style=\"color:#ff0000;background-color: inherit;\">4.多站点配置</span></span></p><p><span style=\"background-color: inherit;\"></span></p><p style=\"line-height: 1.5;\"><span style=\"background-color: inherit;\"><span style=\"color:#262626;font-family:Microsoft YaHei, Verdana, sans-serif, 宋体;font-size:16px;background-color: inherit;\">(1)</span><span style=\"font-family: Consolas; font-size: medium;\">修改文件Apache配置文件 bin\\apache\\apache2.2.22\\conf\\httpd.conf</span></span></p><p style=\"line-height: 1.5; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px;\"><span style=\"background-color: inherit;\"><span style=\"background-color: inherit; color: rgb(38, 38, 38); font-size: 16px;\">找到:</span></span></p><p style=\"line-height: 1.5; color: rgb(255, 0, 0); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px;\"><span style=\"background-color: inherit;\"><span style=\"background-color: inherit; color: rgb(38, 38, 38); font-size: 16px;\">#&nbsp;&nbsp; onlineoffline tag - don&#39;t remove<br style=\"background-color: inherit;\"/>&nbsp;&nbsp;&nbsp; Order Deny,Allow<br style=\"background-color: inherit;\"/>&nbsp;&nbsp;&nbsp; Deny from all<br style=\"background-color: inherit;\"/>&nbsp;&nbsp;&nbsp;</span><span style=\"background-color: inherit; font-size: 16px;\">&nbsp;Allow from 127.0.0.1</span></span></p><p style=\"line-height: 1.5; color: rgb(51, 51, 51); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px;\"><span style=\"background-color: inherit;\"><span style=\"background-color: inherit; color: rgb(38, 38, 38); font-size: 16px;\">改为:</span></span></p><p style=\"line-height: 1.5; color: rgb(255, 0, 0); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px;\"><span style=\"background-color: inherit;\"><span style=\"background-color: inherit; font-size: 15px;\">Allow from all</span></span></p><p style=\"line-height: 1.5; font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 12.5px;\"><span style=\"background-color: inherit;\"><span style=\"background-color: inherit; font-size: 15px;\">(2)开启&nbsp;<span style=\"color: rgb(38, 38, 38); font-size: 16px;\">Include conf/extra/httpd-vhosts.conf</span></span></span></p><p style=\"font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体;\"><span style=\"background-color: inherit;\"><span style=\"font-size:16px;background-color: inherit;\"><span style=\"background-color: inherit; line-height: 24px;\"><span style=\"color:#262626;background-color: inherit;\">(3)添加虚拟主机配置</span><span style=\"color:#3f3f3f;background-color: inherit;\">&nbsp;</span><span style=\"color: rgb(38, 38, 38); font-size: 16px;\">bin\\apache\\Apache2.2.21\\conf\\extra\\httpd-vhosts.conf</span></span></span></span></p><p style=\"font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体;\"><br/></p><p><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&lt;VirtualHost&nbsp;*:80&gt;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;DocumentRoot&nbsp;&quot;E:/www&quot;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;ServerName&nbsp;127.0.0.1</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&lt;/VirtualHost&gt;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&lt;VirtualHost&nbsp;*:80&gt;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;DocumentRoot&nbsp;&quot;E:/www&quot;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;ServerName&nbsp;localhost</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&lt;/VirtualHost&gt;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&lt;VirtualHost&nbsp;*:80&gt;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;DocumentRoot&nbsp;&quot;E:/</span><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px;\">www/shanyu</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&quot;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;ServerName&nbsp;shanyu.com</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;ServerAlias&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px;\">www.shanyu.com<br style=\"background-color: inherit;\"/></span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&lt;/VirtualHost&gt;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&lt;VirtualHost&nbsp;*:80&gt;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;DocumentRoot&nbsp;&quot;E:/</span><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px;\">www/sycms</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&quot;</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;ServerName&nbsp;sycms.com</span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&nbsp;&nbsp;&nbsp;&nbsp;ServerAlias&nbsp;</span><span style=\"background-color: rgb(255, 255, 255); color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px;\">www.sycms.com<br style=\"background-color: inherit;\"/></span><span style=\"color: rgb(0, 0, 0); font-family: 微软雅黑; font-size: 14px; line-height: 21px; background-color: rgb(255, 255, 255);\">&lt;/VirtualHost&gt;</span></p><p><span style=\"background-color: inherit;\"></span></p><p style=\"font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体;\"><br/></p><p><span style=\"background-color: inherit;\">(4)测试情况下:可用域名重定向文件&nbsp;<span style=\"color: rgb(38, 38, 38); font-family: &#39;Microsoft YaHei&#39;, Verdana, sans-serif, 宋体; font-size: 16px;\">C:\\Windows\\System32\\drivers\\etc\\host</span></span></p>', '', 'wampserver,wamp', 'WampServer常用配置:开启伪静态/修改Mysql密码/修改www路径/多站点配置', '2015-08-17 22:23:35', '2015-08-17 21:54:46', '147', '1');
INSERT INTO `sy_article` VALUES ('4', '5', '多维数组与一维数组互转 函数', '', '<p>func listTree</p><p>func treeList</p><pre class=\"brush:php;\">//一维数组转多维数组\r\npublic&nbsp;function&nbsp;listTree($list,&nbsp;$pk=&#39;id&#39;,&nbsp;$pid&nbsp;=&nbsp;&#39;pid&#39;,&nbsp;$child&nbsp;=&nbsp;&#39;_child&#39;,&nbsp;$root&nbsp;=&nbsp;0)&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;创建Tree\r\n&nbsp;&nbsp;&nbsp;&nbsp;$tree&nbsp;=&nbsp;array();\r\n&nbsp;&nbsp;&nbsp;&nbsp;if(is_array($list))&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;创建基于主键的数组引用\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$refer&nbsp;=&nbsp;array();\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;foreach&nbsp;($list&nbsp;as&nbsp;$key&nbsp;=&gt;&nbsp;$data)&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$refer[$data[$pk]]&nbsp;=&amp;&nbsp;$list[$key];\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;foreach&nbsp;($list&nbsp;as&nbsp;$key&nbsp;=&gt;&nbsp;$data)&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;//&nbsp;判断是否存在parent\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$parentId&nbsp;=&nbsp;&nbsp;$data[$pid];\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;($root&nbsp;==&nbsp;$parentId)&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$tree[]&nbsp;=&amp;&nbsp;$list[$key];\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}else{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;(isset($refer[$parentId]))&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$parent&nbsp;=&amp;&nbsp;$refer[$parentId];\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$parent[$child][]&nbsp;=&amp;&nbsp;$list[$key];\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;$tree;\r\n}\r\n\r\n//多维数组转一维数组\r\npublic&nbsp;function&nbsp;treeList($tree,&nbsp;$child&nbsp;=&nbsp;&#39;_child&#39;,&nbsp;$order=&#39;id&#39;,&nbsp;&amp;$list&nbsp;=&nbsp;array()){\r\n&nbsp;&nbsp;&nbsp;&nbsp;if(is_array($tree))&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;foreach&nbsp;($tree&nbsp;as&nbsp;$key&nbsp;=&gt;&nbsp;$value)&nbsp;{\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$reffer&nbsp;=&nbsp;$value;\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if(isset($reffer[$child])){\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unset($reffer[$child]);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tree_to_list($value[$child],&nbsp;$child,&nbsp;$order,&nbsp;$list);\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$list[]&nbsp;=&nbsp;$reffer;\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$list&nbsp;=&nbsp;list_sort_by($list,&nbsp;$order,&nbsp;$sortby=&#39;asc&#39;);\r\n&nbsp;&nbsp;&nbsp;&nbsp;}\r\n&nbsp;&nbsp;&nbsp;&nbsp;return&nbsp;$list;\r\n}</pre><p><br/></p>', '', '多维数组,一维数组', 'func listTreefunc treeList//一维数组转多维数组\r\npublic function listTree($list, $pk=\'id\', $pid = \'pid\', $chi', '2015-08-19 08:36:52', '2015-08-19 08:33:21', '45', '1');
INSERT INTO `sy_article` VALUES ('5', '9', '听说桐岛要退部', '/Uploads/2015-08-19/55d3d06cdf913.jpg', '<p>战斗吧！这才是我们的世界，因为我们不得不在这个世界活下去！</p><p><br/></p><p>日本是世界上排球运动基础最好的国家之一，据统计人均排球运动设施密度最大的国家之一。但日本也是世界排球强国中全盛时期距今日最久远的国家，出产大批身材不高、扣球与拦网高度并不出色但地面技术神勇的男女球员。日本女排的自由人历来都在世界上最好的自由人之列，在最近的时期，1979年出生的自由人佐野优子帮助日本女排在2010世锦赛和2012伦敦奥运会两夺铜牌。这次的故事，就从某高中男排的核心球员和全队精神支柱——忽然宣布退出排球部的主力自由人桐岛说起。&nbsp;</p><p>　　&nbsp;</p><p>　　yyets的字幕将libro翻译成“自由球员”，其实通常的说法是“自由防守人”或“自由防守队员”，简称“自由人”。1996年世界女排大奖赛开始实行自由人规则，每个球队可以在场上派出一名自由人专司一传和防守，此人身着与队友明显区别颜色的球衣，换上换下可不通过裁判员，不计换人次数，不可起跳扣球，不可轮转至前排。国际排联后修订过一次规则，规定大赛每队可报名14人，其中可包括2名自由人，比赛中可由本队的另一名自由人替换场上的自由人，但与其他球员相同，每局只能换上换下一次。&nbsp;</p><p>　　&nbsp;</p><p>　　自由人这个角色，在排球场上的意义相当重大。由于主要负责接一传和防守，是全队后排防守的核心和发动防守反击的基础，成为全队信心的支柱，所以要求行动敏捷、稳重耐劳，故经常由身材矮小、意志坚定者出任。自由人虽然不能进攻得分，但几乎与每一球都有关系，因此往往也深受全队信赖，有独当一面的色彩。片中桐岛退部后，替补自由人小泉风助（太贺）升任主力，像镜头交代的那样，这是一件很矛盾的事情：一方面，他本人当然希望早日打上主力，暗恋他的羽毛球部宫部実果（清水久留巳）也为此高兴；另一方面，他的能力尚不足以帮助球队获胜，县赛关键分未能防起对手斜线强攻造成输球。排球部先辈发泄输球+失去桐岛的愤恨情绪，对小泉风助实施魔鬼训练，全体队友和小泉本人都生活在桐岛那句“我们一起打到毕业”的落空承诺中。&nbsp;</p><p>　　&nbsp;</p><p>　　不知吉田大八及原著小说作者朝井龙为何让桐岛以自由人这个位置出现，而不是更具核心意义的二传手，或者和日本女排当家球星木村纱织一样的主攻手、日本男排球星清水邦广那样的强力接应。也许他们并没有特别想过，也许演员太贺矮小敦实的身材最适合演自由人。至少片中借排球队表现出的青春情绪，完全符合“自由人缺位”这件事情的影响。主力自由人缺席象征的东西，与青春、寂寞、懵懂、时间停滞的状态有诸多相似：不敢相信他人、无人值得依靠、看不到确定的结果、没有可选择的后路、想努力却节奏感始终不对。如片中高中生们展现的那样，屌丝找不到逆袭之路、高富帅不知何处发力、有理想而无伙伴且处处碰壁、有伙伴却时时彼此怀疑。菊池宏树（东出昌大）作为全片“青春情绪”的核心代表，想去社团又不知道为何要去，等待朋友却不知道朋友为何离去，被人要求亲吻却不知道为何要选此时此刻，心中空落落的感觉贯穿全剧，直到被映画部前田凉也（神木隆之介）一句“很帅”彻底点破心门，哭在胶片摄影机古老的方框里。特别是当菊池的两位基友竜汰（落合扶树）和友弘（浅香航大）忽然发现，打篮球已经失去了等桐岛的原初意义时，东出昌大空洞的眼神简直是全剧的眼。&nbsp;</p><p>　　&nbsp;</p><p>　　跟菊池的寂寞比起来，他的爱慕者管乐部部长泽岛亚矢（大后寿寿花）要幸福得多，虽然在楼顶吹奏一直是徒劳的，但吹奏本身是有意义的，和乐团一起完美地演出协奏曲就是她最大的救赎。羽毛球部的宫部実果（清水久留巳）偏偏喜欢替补自由人小泉风助（太贺），因而站在了女生的对立面，有“像姐姐一样的肌肉和球技”的东原霞（桥本爱）对她的心绪不言自明，在楼顶时突然抽了沙奈（松冈茉优）一巴掌，这是对队友宫部最好的同情。在所有人的寂寞当中，东原霞（桥本爱）最无从寻求支撑，手链和地下恋情被发现，与女生们小心翼翼维持的友谊合理地崩坏，他主动投向前田凉也（神木隆之介）的眼神满满地含着左顾右盼，都对不起那罐可乐和那段结结巴巴的“昆汀·塔伦蒂诺”。最无奈的她，最合理地成为了映画部cult片的喷血女主角。由自由人的缺席，最终引出的却是朝夕相处的人们都不是“自由人”的现实，而这却是青春期最残酷却最常见的现实。&nbsp;</p><p><br/></p>', '', '电影,日剧', '战斗吧！这才是我们的世界，因为我们不得不在这个世界活下去！日本是世界上排球运动基础最好的国家之一，据统计人均排球运动设施密度最大的国家之一。但日本也是世界排球强国中全盛时期距今日最久远的国家，出产大批身材不高、扣球与拦网高度并不出色但地面技术神勇的男女球员。日本女排的自由人历来都在世界上最好的自由人', '2015-08-19 10:07:05', '2015-08-19 08:40:09', '16', '1');
INSERT INTO `sy_article` VALUES ('6', '7', 'sublime_快捷键', '/Uploads/2015-08-19/55d3d4e0b2bc9.png', '<p>Ctrl+D 选词 （反复按快捷键，即可继续向下同时选中下一个相同的文本进行同时编辑）</p><p>Ctrl+G 跳转到相应的行</p><p>Ctrl+J 合并行（已选择需要合并的多行时）</p><p>Ctrl+L 选择整行（按住-继续选择下行）</p><p>Ctrl+M 光标移动至括号内开始或结束的位置</p><p>Ctrl+T 词互换</p><p>Ctrl+U 软撤销</p><p>Ctrl+P 查找当前项目中的文件和快速搜索；输入 @ 查找文件主标题/函数；或者输入 : 跳转到文件某行；</p><p>Ctrl+R 快速列出/跳转到某个函数</p><p>Ctrl+K Backspace 从光标处删除至行首</p><p>Ctrl+K+B 开启/关闭侧边栏</p><p>Ctrl+KK 从光标处删除至行尾</p><p>Ctrl+K+T 折叠属性</p><p>Ctrl+K+U 改为大写</p><p>Ctrl+K+L 改为小写</p><p>Ctrl+K+0 展开所有</p><p>Ctrl+Enter 插入行后（快速换行）</p><p>Ctrl+Tab 当前窗口中的标签页切换</p><p><br/></p><p><br/></p><p>Ctrl+Shift+A 选择光标位置父标签对儿</p><p>Ctrl+Shift+D 复制光标所在整行，插入在该行之前</p><p>ctrl+shift+F 在文件夹内查找，与普通编辑器不同的地方是sublime允许添加多个文件夹进行查找</p><p>Ctrl+Shift+K 删除整行</p><p>Ctrl+Shift+L 鼠标选中多行（按下快捷键），即可同时编辑这些行</p><p>Ctrl+Shift+M 选择括号内的内容（按住-继续选择父括号）</p><p>Ctrl+Shift+P 打开命令面板</p><p>Ctrl+Shift+/ 注释已选择内容</p><p>Ctrl+Shift+↑可以移动此行代码，与上行互换</p><p>Ctrl+Shift+↓可以移动此行代码，与下行互换</p><p>Ctrl+Shift+[ 折叠代码</p><p>Ctrl+Shift+] 展开代码</p><p>Ctrl+Shift+Enter 光标前插入行</p><p><br/></p><p><br/></p><p>Ctrl+PageDown 、Ctrl+PageUp 文件按开启的前后顺序切换</p><p><br/></p><p><br/></p><p>Ctrl+Z 撤销</p><p>Ctrl+Y 恢复撤销</p><p>Ctrl+F2 设置/取消书签</p><p>Ctrl+/ 注释整行（如已选择内容，同“Ctrl+Shift+/”效果）</p><p>Ctrl+鼠标左键 可以同时选择要编辑的多处文本</p><p><br/></p><p><br/></p><p>Shift+鼠标右键（或使用鼠标中键）可以用鼠标进行竖向多行选择</p><p>Shift+F2 上一个书签</p><p>Shift+Tab 去除缩进</p><p>Alt+Shift+1（非小键盘）窗口分屏，恢复默认1屏</p><p>Alt+Shift+2 左右分屏-2列</p><p>Alt+Shift+3 左右分屏-3列</p><p>Alt+Shift+4 左右分屏-4列</p><p>Alt+Shift+5 等分4屏</p><p>Alt+Shift+8 垂直分屏-2屏</p><p>Alt+Shift+9 垂直分屏-3屏</p><p><br/></p><p><br/></p><p>Ctrl+Shift+分屏序号 将当前焦点页分配到分屏序号页</p><p><br/></p><p><br/></p><p>Alt+. 闭合当前标签</p><p>Alt+F3 选中文本按下快捷键，即可一次性选择全部的相同文本进行同时编辑</p><p><br/></p><p><br/></p><p>Tab 缩进 自动完成</p><p>F2 下一个书签</p><p>F6 检测语法错误</p><p>F9 行排序(按a-z)</p><p>F11 全屏模式</p><p><br/></p>', '', 'sublime,快捷键', 'Ctrl+D 选词 （反复按快捷键，即可继续向下同时选中下一个相同的文本进行同时编辑）Ctrl+G 跳转到相应的行Ctrl+J 合并行（已选择需要合并的多行时）Ctrl+L 选择整行（按住-继续选择下行）Ctrl+M 光标移动至括号内开始或结束的位置Ctrl+T 词互换Ctrl+U 软撤销Ctrl+', '2015-08-19 10:07:14', '2015-08-19 08:58:29', '105', '1');
INSERT INTO `sy_article` VALUES ('7', '9', '百元之恋_片尾曲', '', '<p>这场电影马上就要结束了</p><p>请忘掉这样的我</p><p>今后的每一天</p><p>就算不拍成电影</p><p>普通地过每天就好</p><p><br/></p><p>但是</p><p>我想在这里</p><p>正如你所见我好不容易站着这里</p><p>却净是些不如意的事情</p><p>模糊的视线里依旧看见的是</p><p>那些刻意生硬的</p><p>终于找到的栖身之所</p><p>完结是因为开始过</p><p>分手是因为相遇过</p><p>这些我都懂</p><p>眼泪只会妨碍我</p><p>去看清那些重要的东西</p><p>明明不想却还是流出来</p><p>反而让我更悲伤</p><p><br/></p><p>我想在这里</p><p>喜欢上一个人也是</p><p>像上了消费税一样</p><p>百元之爱需交八元的爱之稅</p><p>这些我都懂</p><p>眼泪只会妨碍我</p><p>去看清那些重要的东西</p><p>明明不想却还是流出来</p><p>反而让我更悲伤</p><p><br/></p><p>呐~ 为什么怎么都做不好</p><p>呐~ 为什么怎么都做不好</p><p><br/></p><p>我想在这里</p><p>我想在这里</p><p><br/></p>', '', '百元之恋,中文歌词', '这场电影马上就要结束了请忘掉这样的我今后的每一天就算不拍成电影普通地过每天就好但是我想在这里正如你所见我好不容易站着这里却净是些不如意的事情模糊的视线里依旧看见的是那些刻意生硬的终于找到的栖身之所完结是因为开始过分手是因为相遇过这些我都懂眼泪只会妨碍我去看清那些重要的东西明明不想却还是流出来反而让我', '2015-08-19 10:06:57', '2015-08-19 09:00:15', '101', '1');


DROP TABLE IF EXISTS `sy_attachment`;
CREATE TABLE `sy_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `path` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `size` int(10) unsigned NOT NULL DEFAULT '0',
  `ext` char(10) NOT NULL,
  `md5` char(32) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:综合附件,1:图片,2缩略图',
  `upload_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '上传用户ID',
  `upload_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `upload_ip` char(15) NOT NULL,
  `table_name` char(20) NOT NULL DEFAULT '' COMMENT '使用附件的表名',
  `table_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '使用附件的表主键ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_path` (`path`,`name`,`ext`),
  KEY `file_table` (`table_name`,`table_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;


INSERT INTO `sy_attachment` VALUES ('1', 'javascript', '2015-08-17', '55d1b10a1ecb0', '5774', 'jpg', 'c87c68e99e6ecf87e6631875feb43897', '2', '1', '2015-08-17 18:01:46', '127.0.0.1', 'article', '1');
INSERT INTO `sy_attachment` VALUES ('2', '焦点图01', '2015-08-17', '55d1dd25124c0', '189314', 'png', '6daf5a48ba919b4d0ef9d42e1792499a', '2', '1', '2015-08-17 21:09:57', '127.0.0.1', 'nav', '6');
INSERT INTO `sy_attachment` VALUES ('3', '焦点图02', '2015-08-17', '55d1dd640e3cf', '44203', 'jpg', '5d38b714d45fe1aff468a9cbca11edef', '2', '1', '2015-08-17 21:11:00', '127.0.0.1', 'nav', '7');
INSERT INTO `sy_attachment` VALUES ('4', 'wamperver', '2015-08-17', '55d1e8260a381', '4549', 'gif', '40ae9a1a94fade2e8cbe2858e0fa85f8', '2', '1', '2015-08-17 22:02:39', '127.0.0.1', 'article', '3');
INSERT INTO `sy_attachment` VALUES ('5', '听说桐岛要退部', '2015-08-19', '55d3d06cdf913', '22037', 'jpg', 'bb8dbbc88d469da9e24d463d3f02c3bb', '2', '1', '2015-08-19 08:40:12', '127.0.0.1', 'article', '5');
INSERT INTO `sy_attachment` VALUES ('6', 'sublime', '2015-08-19', '55d3d4e0b2bc9', '44118', 'png', 'e3b4e5942df762d6f950418beabb1f87', '1', '1', '2015-08-19 08:59:12', '127.0.0.1', 'article', '6');


DROP TABLE IF EXISTS `sy_auth_access`;
CREATE TABLE `sy_auth_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `sy_auth_group`;
CREATE TABLE `sy_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `pid` mediumint(8) unsigned NOT NULL,
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  `remark` varchar(80) NOT NULL DEFAULT '' COMMENT '自定:描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:员工权限,2:公司权限',
  `sort` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


INSERT INTO `sy_auth_group` VALUES ('1', '0', '文章编辑', '99,100,105,101,106,102,109,22,23,24,25,26,27,28,29,30,31,32,33,80,83,94,95,34,35,36,37,38,39,68,69,70,71,107,108,45,46,77,76,78,79,81,82,103,104,115,116', '文章编辑人员权限组', '1', '1', '0');
INSERT INTO `sy_auth_group` VALUES ('2', '0', '管理员', '1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,99,100,105,101,106,102,109,22,23,24,25,26,27,28,29,30,31,32,33,80,83,94,95,34,35,36,37,38,39,68,69,70,71,107,108,45,46,77,76,78,79,81,82,103,104,115,116,48,49,50,51,52,53,54,55,56,117,118,66,67,72,84,85,119,120,111,112,113,114', '普通后台管理员权限', '1', '1', '0');


DROP TABLE IF EXISTS `sy_auth_rule`;
CREATE TABLE `sy_auth_rule` (
  `id` smallint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1:节点;2:菜单',
  `pid` smallint(8) unsigned NOT NULL DEFAULT '0' COMMENT '自定:层级关系',
  `sort` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '自定:排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `icon` char(10) NOT NULL DEFAULT '' COMMENT '符号',
  `condition` char(20) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;


INSERT INTO `sy_auth_rule` VALUES ('1', '系统', 'Admin/AuthGroup/index', '3', '0', '3', '1', 'auth', '');
INSERT INTO `sy_auth_rule` VALUES ('2', '权限控制', 'Admin/AuthGroup/index', '3', '1', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('3', '权限分组', 'Admin/AuthGroup/index', '2', '2', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('4', '分组列表', 'Admin/AuthGroup/index', '1', '3', '3', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('5', '添加分组', 'Admin/AuthGroup/add', '1', '3', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('6', '删除分组', 'Admin/AuthGroup/del', '1', '3', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('7', '编辑分组', 'Admin/AuthGroup/edit', '1', '3', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('8', '授予权限', 'Admin/AuthGroup/rule', '1', '3', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('9', '菜单权限', 'Admin/AuthRule/index', '2', '2', '3', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('10', '菜单列表', 'Admin/AuthRule/index', '1', '9', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('11', '添加菜单', 'Admin/AuthRule/add', '1', '9', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('12', '编辑菜单', 'Admin/AuthRule/edit', '1', '9', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('13', '删除菜单', 'Admin/AuthRule/del', '1', '9', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('15', '后台管理员', 'Admin/Admin/index', '2', '2', '1', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('16', '成员列表', 'Admin/Admin/index', '1', '15', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('17', '添加成员', 'Admin/Admin/add', '1', '15', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('18', '编辑成员', 'Admin/Admin/edit', '1', '15', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('19', '删除成员', 'Admin/Admin/del', '1', '15', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('20', '操作日志', 'Admin/AdminLog/index', '2', '2', '4', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('21', '日志列表', 'Admin/AdminLog/index', '1', '20', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('22', '内容', 'Admin/Category/index', '3', '0', '2', '1', 'content', '');
INSERT INTO `sy_auth_rule` VALUES ('23', '栏目管理', 'Admin/Category/index', '3', '22', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('24', '栏目分类', 'Admin/Category/index', '2', '23', '1', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('25', '栏目列表', 'Admin/Category/index', '1', '24', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('26', '添加栏目', 'Admin/Category/add', '1', '24', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('27', '编辑栏目', 'Admin/Category/edit', '1', '24', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('28', '删除栏目', 'Admin/Category/del', '1', '24', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('29', '栏目模型', 'Admin/Model/index', '2', '23', '4', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('30', '模型列表', 'Admin/Model/index', '1', '29', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('31', '增加模型', 'Admin/Model/add', '1', '29', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('32', '编辑模型', 'Admin/Model/edit', '1', '29', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('33', '删除模型', 'Admin/Model/del', '1', '29', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('34', '综合数据', 'Admin/Data/index', '3', '22', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('35', '数据块管理', 'Admin/Data/index', '2', '34', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('36', '数据列表', 'Admin/Data/index', '1', '35', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('37', '添加数据', 'Admin/Data/add', '1', '35', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('38', '修改数据', 'Admin/Data/edit', '1', '35', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('39', '删除数据', 'Admin/Data/del', '1', '35', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('45', '栏目内容', 'Admin/Article/index', '3', '22', '1', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('46', '文章管理', 'Admin/Article/index', '2', '45', '1', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('77', '添加文章', 'Admin/Article/add', '1', '46', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('48', '配置', 'Admin/Config/groups', '3', '0', '4', '1', 'config', '');
INSERT INTO `sy_auth_rule` VALUES ('49', '参数配置', 'Admin/Config/groups', '3', '48', '1', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('50', '全部配置', 'Admin/Config/index', '2', '49', '3', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('51', '配置列表', 'Admin/Config/index', '1', '50', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('52', '增加配置', 'Admin/Config/add', '1', '50', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('53', '删除配置', 'Admin/Config/del', '1', '50', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('54', '修改配置', 'Admin/Config/edit', '1', '50', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('55', '常用配置', 'Admin/Config/groups', '2', '49', '1', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('56', '常用配置', 'Admin/Config/shortcut', '1', '55', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('76', '文章列表', 'Admin/Article/index', '1', '46', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('66', '数据文件', 'Admin/Database/index', '3', '48', '3', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('67', '数据库管理', 'Admin/Database/index', '2', '66', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('68', '附件管理', 'Admin/Attachment/index', '2', '34', '3', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('69', '附件列表', 'Admin/File/index', '1', '68', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('70', '附件清理', 'Admin/File/clear', '1', '68', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('71', '附件修改', 'Admin/File/edit', '1', '68', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('72', '数据列表', 'Admin/Database/index', '1', '67', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('78', '编辑文章', 'Admin/Article/edit', '1', '46', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('79', '删除文章', 'Admin/Article/del', '1', '46', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('80', 'URL路由', 'Admin/UrlMap/index', '2', '23', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('81', '单页管理', 'Admin/Page/index', '2', '45', '3', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('82', '单页列表', 'Admin/Page/index', '1', '81', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('83', '路由列表', 'Admin/Route/index', '1', '80', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('84', '数据库备份', 'Admin/Database/backupList', '2', '66', '3', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('85', '备份列表', 'Admin/Database/backupList', '1', '84', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('91', '国内新闻', 'Admin/Article/index/cid/45', '2', '45', '0', '0', '', '');
INSERT INTO `sy_auth_rule` VALUES ('92', '国内新闻列表', 'Admin/Content/index?cid=45', '1', '91', '0', '0', '', '');
INSERT INTO `sy_auth_rule` VALUES ('93', '修改国内新闻', 'Admin/Content/edit?cid=45', '1', '91', '0', '0', '', '');
INSERT INTO `sy_auth_rule` VALUES ('94', '标签管理', 'Admin/Tags/index', '2', '23', '3', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('95', '标签列表', 'Admin/Tags/index', '1', '94', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('119', '新浪SAE', 'Admin/Kvdb/index', '3', '48', '4', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('99', '我的面板', 'Admin/Index/my', '3', '1', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('100', '系统信息', 'Admin/Index/system', '2', '99', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('101', '我的资料', 'Admin/Admin/my', '2', '99', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('102', '快捷菜单', 'Admin/AdminMenu/index', '2', '99', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('103', '图集管理', 'Admin/Picture/index', '2', '45', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('104', '图集列表', 'Admin/Picture/index', '1', '103', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('105', '系统信息', 'Admin/Index/system', '1', '100', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('106', '我的资料', 'Admin/Admin/my', '1', '101', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('107', '导航管理', 'Admin/Nav/index', '2', '34', '1', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('108', '导航列表', 'Admin/Nav/index', '1', '107', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('109', '快捷列表', 'Admin/AdminMenu/index', '1', '102', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('111', '文件管理', 'Admin/FileManage/index', '3', '48', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('112', '模板文件', 'Admin/FileManage/index', '2', '111', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('113', '缓存文件', 'Admin/FileManage/index?root=Runtime', '2', '111', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('114', '备份文件', 'Admin/FileManage/index?root=Backups', '2', '111', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('115', '扩展模块', 'Admin/Guestbook/index', '3', '22', '3', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('116', '留言板', 'Admin/Guestbook/index', '2', '115', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('117', '上传配置', 'Admin/Config/upload', '2', '49', '2', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('118', '上传配置', 'Admin/Config/config', '1', '117', '0', '1', '', '');
INSERT INTO `sy_auth_rule` VALUES ('120', 'Kvdb缓存', 'Admin/Kvdb/index', '2', '119', '0', '1', '', '');


DROP TABLE IF EXISTS `sy_category`;
CREATE TABLE `sy_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `mid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属模型ID',
  `name` varchar(15) NOT NULL DEFAULT '' COMMENT '栏目英文名',
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT '栏目中文名',
  `url` varchar(100) NOT NULL COMMENT '栏目链接',
  `image` varchar(100) NOT NULL COMMENT '栏目缩略图',
  `setting` mediumtext NOT NULL COMMENT '栏目配置',
  `is_menu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0:普通栏目,1:目录栏目',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  `type` tinyint(4) NOT NULL COMMENT '1:栏目,2:单页,3:模块,4:内链,5:外链',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='栏目分类表';


INSERT INTO `sy_category` VALUES ('1', '0', '1', 'web', '前端特效', '', '', 'a:5:{s:10:\"meta_title\";s:12:\"前端特效\";s:13:\"meta_keywords\";s:28:\"HTML5,CSS3,Javascript,Jquery\";s:16:\"meta_description\";s:46:\"HTML5,CSS3,Javascript,Jquery技术资料分享\";s:13:\"template_list\";s:10:\"List_index\";s:13:\"template_show\";s:10:\"Show_index\";}', '1', '1', 'HTML5,CSS3,Javascript,Jquery技术资料分享', '1', '0');
INSERT INTO `sy_category` VALUES ('2', '1', '1', 'javascript', 'JavaScript', '', '', 'a:5:{s:10:\"meta_title\";s:12:\"交互特效\";s:13:\"meta_keywords\";s:17:\"javascript,jquery\";s:16:\"meta_description\";s:47:\"javascript,jquery前端交互特效实例分享\";s:13:\"template_list\";s:10:\"List_index\";s:13:\"template_show\";s:10:\"Show_index\";}', '0', '0', '', '1', '0');
INSERT INTO `sy_category` VALUES ('3', '0', '1', 'service', '后端数据', '', '', 'a:5:{s:10:\"meta_title\";s:12:\"后端数据\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:13:\"template_list\";s:10:\"List_index\";s:13:\"template_show\";s:10:\"Show_index\";}', '1', '2', '', '1', '0');
INSERT INTO `sy_category` VALUES ('4', '3', '1', 'linux', 'Linux', '', '', 'a:5:{s:10:\"meta_title\";s:5:\"Linux\";s:13:\"meta_keywords\";s:12:\"linux,centos\";s:16:\"meta_description\";s:33:\"网络服务器技术资料分享\";s:13:\"template_list\";s:10:\"List_index\";s:13:\"template_show\";s:10:\"Show_index\";}', '0', '0', '', '1', '0');
INSERT INTO `sy_category` VALUES ('5', '3', '1', 'php', 'PHP', '', '', 'a:5:{s:10:\"meta_title\";s:3:\"PHP\";s:13:\"meta_keywords\";s:3:\"PHP\";s:16:\"meta_description\";s:21:\"PHP技术资料分享\";s:13:\"template_list\";s:10:\"List_index\";s:13:\"template_show\";s:10:\"Show_index\";}', '0', '0', '', '1', '0');
INSERT INTO `sy_category` VALUES ('8', '0', '1', 'life', '心情日记', '', '', 'a:5:{s:10:\"meta_title\";s:12:\"心情日记\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:13:\"template_list\";s:10:\"List_index\";s:13:\"template_show\";s:10:\"Show_index\";}', '1', '4', '', '1', '0');
INSERT INTO `sy_category` VALUES ('9', '8', '1', 'diary', 'Diary', '', '', 'a:5:{s:10:\"meta_title\";s:5:\"Diary\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:13:\"template_list\";s:10:\"List_index\";s:13:\"template_show\";s:10:\"Show_index\";}', '0', '0', '', '1', '0');
INSERT INTO `sy_category` VALUES ('6', '0', '1', 'tool', '开发工具', '', '', 'a:5:{s:10:\"meta_title\";s:12:\"开发工具\";s:13:\"meta_keywords\";s:25:\"开发工具,编程工具\";s:16:\"meta_description\";s:30:\"常用编程工具使用教程\";s:13:\"template_list\";s:10:\"List_index\";s:13:\"template_show\";s:10:\"Show_index\";}', '1', '3', '', '1', '0');
INSERT INTO `sy_category` VALUES ('7', '6', '1', 'sublime', 'Sublime', '', '', 'a:5:{s:10:\"meta_title\";s:7:\"Sublime\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:0:\"\";s:13:\"template_list\";s:10:\"List_index\";s:13:\"template_show\";s:10:\"Show_index\";}', '0', '0', '', '1', '0');
INSERT INTO `sy_category` VALUES ('10', '0', '2', 'about', '关于本站', '', '', 'a:4:{s:10:\"meta_title\";s:12:\"关于本站\";s:13:\"meta_keywords\";s:0:\"\";s:16:\"meta_description\";s:27:\"关于本站的详细描述\";s:13:\"template_page\";s:10:\"Page_index\";}', '0', '5', '', '1', '0');


DROP TABLE IF EXISTS `sy_config`;
CREATE TABLE `sy_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '配置标记',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '0:数组,1:字符串,2:整型,3:布尔',
  `value` varchar(255) NOT NULL COMMENT '配置值',
  `extra` varchar(200) NOT NULL COMMENT '选择类型的参数',
  `remark` varchar(100) NOT NULL COMMENT '备注',
  `groups` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `module` char(20) NOT NULL DEFAULT 'Common' COMMENT '模块',
  `is_system` tinyint(3) NOT NULL DEFAULT '0',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  `sort` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `group` (`groups`)
) ENGINE=MyISAM AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;


INSERT INTO `sy_config` VALUES ('1', '站点名称', 'SITE_TITLE', '1', '#site_title#', '', '网站标题(25个字至50个字节以内)', '1', 'Home', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('201', '碎片数据分组', 'DATA_GROUPS', '11', '1:全局数据\r\n2:首页数据\r\n3:列表页数据\r\n4:详情页数据\r\n', '', '数据块分组', '0', 'Admin', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('202', '公共权限控制器', 'ALLOW_VISIT', '11', 'Index\r\nPublic', '', '不设权限限制的控制器', '0', 'Admin', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('203', '超级权限控制器', 'DENY_VISIT', '11', 'Common', '', '只有超级管理员才能访问的控制器', '0', 'Admin', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('2', '关键字', 'SITE_KEYWORDS', '1', '关键词(5个词左右,单个词8汉字以内)', '', '关键词(5个词左右,单个词8汉字以内)', '1', 'Home', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('3', '站点描述', 'SITE_DESCRIPTION', '2', '网站描述(字数80个汉字，160个字符以内)', '', '网站描述(字数80个汉字，160个字符以内)', '1', 'Home', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('52', '站点状态', 'SITE_STATUS', '9', '1', '', '是否开启站点', '5', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('5', '版权声明', 'SITE_COPYRIGHT', '2', '版权所有 © 2015 XXXXXX有限公司<br/>\r\nCopyright © 2015 XXX.com All Rights Reserved<br/>\r\n备案号 豫ICP备140XXXXX号', '', '网站版权声明', '1', 'Home', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('7', '联系邮箱', 'SITE_EMAIL', '1', '#email#', '', '站长联系邮箱', '1', 'Home', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('30', '短信平台', 'SMS_HOST', '10', 'Ihuyi', 'Smsbao:短信宝\r\nIhuyi:互亿无线', '短信平台服务商', '3', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('204', 'COOKIE前缀', 'COOKIE_PREFIX', '1', 'sy_', '', '全局cookie前缀', '0', 'Common', '1', '0', '0');
INSERT INTO `sy_config` VALUES ('6', '统计代码', 'SITE_STATISTICS', '2', '<script>var _hmt=_hmt||[];(function(){var hm=document.createElement(\"script\");hm.src=\"//hm.baidu.com/hm.js?a0d57735a6fdc7ded77d66506f86f2da\";var s=document.getElementsByTagName(\"script\")[0];s.parentNode.insertBefore(hm,s)})();</script>', '', '前台全局统计代码', '1', 'Home', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('116', '开启水印', 'UPLOAD_WATER', '9', '1', '', '是否开启加盖水印', '11', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('117', '水印路径', 'UPLOAD_WATER_PATH', '1', 'Public/Img/water.png', '', '水印图片路径', '11', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('115', '缩略图宽度', 'UPLOAD_THUMB_WIDTH', '1', '200', '', '单位为px', '11', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('114', '缩略图高度', 'UPLOAD_THUMB_HEIGHT', '1', '200', '', '单位为px', '11', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('40', '邮箱服务器', 'EMAIL_HOST', '1', 'smtp.qq.com', '', '例如:smtp.qq.com', '4', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('43', '邮箱账号', 'EMAIL_USERNAME', '1', '', '', '邮箱登陆账号', '4', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('44', '邮箱密码', 'EMAIL_PASSWORD', '1', '', '', '邮箱登陆密码', '4', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('42', '发件人名称', 'EMAIL_FROM', '1', 'Shanyu', '', '发送邮件时显示的发件人名称', '4', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('51', '显示调试栏', 'SHOW_PAGE_TRACE', '9', '1', '', '右下角TRACE栏', '5', 'Common', '1', '1', '0');
INSERT INTO `sy_config` VALUES ('35', '短信剩余条数', 'SMS_NUM', '3', '6', '', '仅用于存储短信剩余数目', '3', 'Admin', '0', '0', '0');
INSERT INTO `sy_config` VALUES ('34', '短信状态', 'SMS_STATUS', '9', '1', '', '是否开启短信平台', '3', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('32', '短信账号', 'SMS_USERNAME', '1', '', '', '短信平台的账号', '3', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('33', '短信密码', 'SMS_PASSWORD', '1', '', '', '短信平台的密码', '3', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('206', '导航分组', 'NAV_GROUPS', '11', '1:首页焦点图\r\n2:列表焦点图\r\n3:顶部导航\r\n4:底部导航\r\n5:友情链接', '', '前台菜单分组', '0', 'Admin', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('9', '联系地址', 'SITE_ADRESS', '1', '河南省郑州市', '', '站长联系地址', '1', 'Home', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('8', '联系电话', 'SITE_PHONE', '1', '13612345678', '', '站长联系电话', '1', 'Home', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('53', '网站关闭提示', 'SITE_CLOSE_INFO', '2', '站点维护中，请稍等一会...', '', '前台网站关闭提示', '5', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('41', '邮箱服务端口', 'EMAIL_PORT', '3', '25', '', '', '4', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('113', '允许上传类型', 'UPLOAD_ALLOW', '2', 'jpg,gif,png,jpeg,txt,doc,docx,xls,ppt,zip,rar,mp3', '', '文件后缀', '11', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('112', '允许上传大小', 'UPLOAD_MAXSIZE', '3', '2048', '', '单位为KB', '11', 'Common', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('50', '前台模板主题', 'DEFAULT_THEME', '10', 'Default', 'Default:默认模板\r\nJixie:机械企业模板', '当选使用的模版主题', '5', 'Home', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('110', '上传空间选择项', 'FILE_UPLOAD_TYPE', '10', 'Local', 'Local:本地空间\r\nUpyun:又拍云\r\nQiniu:七牛云\r\nBcs:百度云\r\nFtp:FTP空间', '当前使用空间', '11', 'Common', '1', '1', '0');
INSERT INTO `sy_config` VALUES ('111', '上传空间配置', 'UPLOAD_TYPE_CONFIG', '11', '', '', '当前使用配置', '11', 'Common', '1', '1', '0');
INSERT INTO `sy_config` VALUES ('118', '上传空间配置_又拍云', 'UPLOAD_TYPE_CONFIG_UPYUN', '11', '', '', '又拍云空间', '11', 'Admin', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('119', '上传空间配置_七牛', 'UPLOAD_TYPE_CONFIG_QINIU', '11', '', '', '七牛云空间', '11', 'Admin', '0', '1', '0');
INSERT INTO `sy_config` VALUES ('205', 'COOKIE加密密钥', 'COOKIE_SAFE_KEY', '1', 'uAXa3mtI1', '', '用于解密COOKIE字符串', '0', 'Common', '1', '0', '0');
INSERT INTO `sy_config` VALUES ('256', '标签分组', 'TAG_GROUPS', '11', '0:默认分组\r\n1:分组一\r\n2:分组二\r\n3:分组三', '', 'TAG分组', '0', 'Admin', '0', '1', '0');


DROP TABLE IF EXISTS `sy_data`;
CREATE TABLE `sy_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '变量名称',
  `name` varchar(100) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `value` varchar(1000) NOT NULL COMMENT '变量值',
  `remark` varchar(50) NOT NULL COMMENT '参数说明',
  `catid` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '数据所属栏目',
  `groups` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '变量类型',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nam` (`name`) USING HASH
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


INSERT INTO `sy_data` VALUES ('1', '公共底部关于我们', 'foot_about', '1', '本站转载的文章，均会标示出处，只有部分无法溯源的文章（主要来源于早期本地保存收藏内容）可能没有标示，这些文章版权为原作者所有，如果涉及版权等异议问题，可以随时EMAIL联系kukj删除。', '', '0', '1', '0', '0');


DROP TABLE IF EXISTS `sy_guestbook`;
CREATE TABLE `sy_guestbook` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL DEFAULT '',
  `mobile` varchar(15) NOT NULL DEFAULT '',
  `add_ip` varchar(20) NOT NULL DEFAULT '',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `content` text,
  `reply_uid` int(10) unsigned NOT NULL DEFAULT '0',
  `reply_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reply` text,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


INSERT INTO `sy_guestbook` VALUES ('1', '木木', '13873663532', '127.0.0.1', '2015-08-17 22:18:19', '刚刚开始,继续努力吧! :)', '1', '2015-08-17 22:21:54', '谢谢,为了明天,加油!~', '1');


DROP TABLE IF EXISTS `sy_model`;
CREATE TABLE `sy_model` (
  `id` smallint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `model_name` varchar(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `model_table` varchar(30) NOT NULL DEFAULT '' COMMENT '表单名称',
  `model_controller` varchar(30) NOT NULL COMMENT '模型控制器',
  `template_list` char(15) NOT NULL,
  `template_show` char(15) NOT NULL,
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;


INSERT INTO `sy_model` VALUES ('1', '文章模型', 'article', 'Article', 'List_index', 'Show_index', '新闻,博文', '1');
INSERT INTO `sy_model` VALUES ('3', '图集模型', 'picture', 'Picture', 'List_picture', 'Show_picture', '案例', '1');
INSERT INTO `sy_model` VALUES ('2', '单页模型', 'page', 'Page', 'List_index', 'Show_page', '单页', '1');


DROP TABLE IF EXISTS `sy_nav`;
CREATE TABLE `sy_nav` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `groups` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `title` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `image` varchar(100) NOT NULL,
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;


INSERT INTO `sy_nav` VALUES ('1', '1', '5', '百度搜索', 'http://www.baidu.com', '', '', '0', '1');
INSERT INTO `sy_nav` VALUES ('2', '1', '5', '凤凰网', 'http://www.ifeng.com', '', '', '0', '1');
INSERT INTO `sy_nav` VALUES ('3', '1', '5', '腾讯网', 'http://www.qq.com', '', '', '0', '1');
INSERT INTO `sy_nav` VALUES ('4', '1', '5', '豆瓣网', 'http://www.douban.com', '', '', '0', '1');
INSERT INTO `sy_nav` VALUES ('5', '1', '5', 'THINKPHP', 'http://www.thinkphp.cn', '', '', '0', '1');
INSERT INTO `sy_nav` VALUES ('6', '1', '1', 'OneThink', 'javascript:;', '', '/Uploads/2015-08-17/55d1dd25124c0.png', '0', '1');
INSERT INTO `sy_nav` VALUES ('7', '1', '1', 'Addons', 'javascript:;', '', '/Uploads/2015-08-17/55d1dd640e3cf.jpg', '0', '1');


DROP TABLE IF EXISTS `sy_page`;
CREATE TABLE `sy_page` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL COMMENT '内容',
  `keywords` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `add_time` datetime NOT NULL,
  `edit_time` datetime NOT NULL,
  `sort` tinyint(4) NOT NULL,
  `view` int(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


INSERT INTO `sy_page` VALUES ('1', '10', '关于本站', '<p>关于本站内容</p><p>1.&nbsp;本站转载的文章，均会标示出处，只有部分无法溯源的文章（主要来源于早期本地保存收藏内容）可能没有标示，这些文章版权为原作者所有，如果涉及版权等异议问题，可以随时EMAIL联系kukj删除。</p><p><br/></p><p>2. 除特别注明外全部为原创文章，谨供网友学习、研究和交流参考使用，kukj不对文章的使用后果或潜在后果负责，且保留随时删除或修改的权利。</p><p><br/></p><p>3. 仅欢迎遵守署名、非商业用途和保持一致的转载或使用，未经kukj授权严禁作为商业用途使用，谢绝所有不遵守署名、非商业用途和保持一致的转载或使用。对非法转载行为（包括但不限于去链接、去水印、伪原创、去署名等），kukj保留一切追究责任的权利。</p><p><br/></p><p>4. 本站上涉及各公司标识、徽标以及专利名词，其版权均归原注册版权人所有，kukj仅作积极方面的宣传和倡导，如系统或软件权利持有人认为侵权或可能造成侵权，请联系下面的kukj邮箱，kukj收到后会第一时间删除相关内容。</p>', '关于网站', '关于网站', '2015-08-19 08:56:03', '2015-08-19 09:13:50', '0', '0', '1');


DROP TABLE IF EXISTS `sy_picture`;
CREATE TABLE `sy_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `cid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `title` varchar(60) NOT NULL DEFAULT '' COMMENT '标题',
  `thumb` varchar(150) NOT NULL DEFAULT '' COMMENT '缩略图',
  `content` text NOT NULL COMMENT '内容',
  `keywords` varchar(50) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '摘要描述',
  `edit_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `add_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  `view` int(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  `images` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS `sy_session`;
CREATE TABLE `sy_session` (
  `session_id` char(32) NOT NULL,
  `session_expire` int(11) NOT NULL,
  `session_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `expire` (`session_expire`) USING HASH
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;




DROP TABLE IF EXISTS `sy_tag`;
CREATE TABLE `sy_tag` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'tagID',
  `title` char(20) NOT NULL COMMENT 'tag名称',
  `view` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '浏览数',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `groups` tinyint(4) NOT NULL DEFAULT '0' COMMENT '分组',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag` (`title`),
  KEY `usetimes` (`sort`),
  KEY `hits` (`view`,`sort`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='tags主表';


INSERT INTO `sy_tag` VALUES ('1', 'Jquery', '3', '0', '1', '0');
INSERT INTO `sy_tag` VALUES ('2', 'JavaScript', '14', '0', '1', '0');
INSERT INTO `sy_tag` VALUES ('3', 'Linux', '1', '0', '1', '0');
INSERT INTO `sy_tag` VALUES ('4', 'Wamp', '1', '0', '1', '0');


DROP TABLE IF EXISTS `sy_urlmap`;
CREATE TABLE `sy_urlmap` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `url` varchar(100) NOT NULL COMMENT '完整url， 如：portal/list/index?id=1',
  `route` varchar(100) NOT NULL COMMENT '实际显示的url',
  `sort` int(5) NOT NULL DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态，1：启用 ;0：不启用',
  `groups` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:通用,1:栏目,2:单页,3:模块',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;


INSERT INTO `sy_urlmap` VALUES ('1', 'list/index?cname=web', 'web', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('2', 'list/index?cname=javascript', 'javascript', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('3', 'list/index?cname=service', 'service', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('4', 'list/index?cname=linux', 'linux', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('5', 'guestbook/index', 'guestbook', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('6', 'list/index?cname=php', 'php', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('7', 'list/index?cname=life', 'life', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('8', 'list/index?cname=diary', 'diary', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('9', 'list/index?cname=tool', 'tool', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('10', 'list/index?cname=sublime', 'sublime', '0', '1', '0');
INSERT INTO `sy_urlmap` VALUES ('11', 'page/index?cname=about', 'about', '0', '1', '0');