
CREATE TABLE `users` (
  `cid` varchar(18) NOT NULL COMMENT '사용자아이디',
  `passwd` varchar(256) NOT NULL COMMENT '비밀번호',
  `name` varchar(20) NOT NULL COMMENT '사용자명',
  `cell_phone` varchar(15) NOT NULL COMMENT '휴대폰번호',
  `email` varchar(50) DEFAULT NULL COMMENT '이메일',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `mf_code` varchar(9) DEFAULT NULL COMMENT '제조사코드',
  `position` varchar(15) DEFAULT NULL COMMENT '직급',
  `extension` varchar(15) DEFAULT NULL COMMENT '내선번호',
  `sms_rcv` char(2) CHARACTER SET latin1 DEFAULT '00' COMMENT 'SMS수신여부',
  `crt_id` varchar(20) DEFAULT NULL COMMENT '등록자',
  `crt_dttm` datetime DEFAULT NULL COMMENT '등록일시',
  `upd_id` varchar(20) DEFAULT NULL COMMENT '수정자 아이디',
  `upd_dttm` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='고객테이블';

