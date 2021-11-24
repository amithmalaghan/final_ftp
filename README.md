#how to config mysql


#create mysql docker file
FROM mysql:5.7
ENV MYSQL_ROOT_PASSWORD: PASS
EXPOSE 3306

#To run the container
docker run -t -p 3000:3306 <mysql_conatiner_name>

# to login to mysql
1) open the container terminal and run
>mysql -u root -ppass;

#create database
>create database ftpd;

#to select database 
>use ftpd;


# to create table;
CREATE TABLE IF NOT EXISTS `ftpgroup` (
  `groupname` varchar(16) COLLATE utf8_general_ci NOT NULL,
  `gid` smallint(6) NOT NULL DEFAULT '5500',
  `members` varchar(16) COLLATE utf8_general_ci NOT NULL,
  KEY `groupname` (`groupname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='proftpd group table';CREATE TABLE IF NOT EXISTS `ftpuser` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `passwd` varchar(32) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `uid` smallint(6) NOT NULL DEFAULT '5500',
  `gid` smallint(6) NOT NULL DEFAULT '5500',
  `homedir` varchar(255) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `shell` varchar(16) COLLATE utf8_general_ci NOT NULL DEFAULT '/sbin/nologin',
  `count` int(11) NOT NULL DEFAULT '0',
  `accessed` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='proftpd user table';

#to encrypt passwd in openssl

/bin/echo "{md5}"`/bin/echo -n "<password>" | openssl dgst -binary -md5 | openssl enc -base64`

# to insert value in proftpd

INSERT INTO `ftpuser` (`id`, `userid`, `passwd`, `uid`, `gid`, `homedir`, `shell`, `count`, `accessed`, `modified`) VALUES ('2', 'amit', '{md5}X03MO1qnZdYdgyfeuILPmQ==', '5500', '5500', '/home/amit1', '/sbin/nologin', '0', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
