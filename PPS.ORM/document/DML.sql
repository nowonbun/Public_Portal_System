INSERT INTO MST_STATE(STATE,NAME) VALUES ('100','Goolgle ID');
INSERT INTO MST_STATE(STATE,NAME) VALUES ('101','Private ID');
INSERT INTO MST_STATE(STATE,NAME) VALUES ('200','Applying');
INSERT INTO MST_STATE(STATE,NAME) VALUES ('201','Application refused');
INSERT INTO MST_STATE(STATE,NAME) VALUES ('202','Application approved');
INSERT INTO MST_STATE(STATE,NAME) VALUES ('999','Default Transaction Data');
INSERT INTO MST_LOOK_UP(`KEY`,`VALUE`) VALUES('DefaultCompany','');
INSERT INTO MST_LOOK_UP(`KEY`,`VALUE`) VALUES('DefaultGroup','');

INSERT INTO MST_CARD_STEP(STEP, NAME) VALUES ('HOME','Main tile');
INSERT INTO MST_CARD_STEP(STEP, NAME) VALUES ('ADMN', 'Admin tile');
INSERT INTO MST_CARD_STEP(STEP, NAME) VALUES ('MAST', 'Master setting tile');
INSERT INTO MST_CARD_STEP(STEP, NAME) VALUES ('MODL', 'Modal type');

INSERT INTO MST_CARD_TYPE(CARD_TYPE,NAME) VALUES ('IMG','Image Card');
INSERT INTO MST_CARD_TYPE(CARD_TYPE,NAME) VALUES ('EVT','Event Card');
INSERT INTO MST_CARD_TYPE(CARD_TYPE,NAME) VALUES ('MDL','Modal Card');
INSERT INTO MST_CARD_TYPE(CARD_TYPE,NAME) VALUES ('IMC','Image Menu Card');
INSERT INTO MST_CARD_TYPE(CARD_TYPE,NAME) VALUES ('EMC','Event Menu Card');

INSERT INTO MST_CARD (CODE,NAME,HREF,STEP,TITLE,DESCRIPTION,IMG,ICON,COLOR,CARD_TYPE,CONTROL,TEMPLATE,ORDER_SEQ) VALUES ('ADMN','Admin',null,'HOME','Admin','',null,null,null,'IMC','admin', './views/card.tpl.jsp',1);
INSERT INTO MST_CARD (CODE,NAME,HREF,STEP,TITLE,DESCRIPTION,IMG,ICON,COLOR,CARD_TYPE,CONTROL,TEMPLATE,ORDER_SEQ) VALUES ('PRFL','Profile',null,'MODL','Profile','',null,null,null,'MDL','profile','./views/profile.tpl.jsp',2);
INSERT INTO MST_CARD (CODE,NAME,HREF,STEP,TITLE,DESCRIPTION,IMG,ICON,COLOR,CARD_TYPE,CONTROL,TEMPLATE,ORDER_SEQ) VALUES ('USMN','User Management','./#!/usermanagement','ADMN','User Management','',null,null,null,'IMG', 'usermanagement','./views/usermanagement.tpl.jsp',1);
INSERT INTO MST_CARD (CODE,NAME,HREF,STEP,TITLE,DESCRIPTION,IMG,ICON,COLOR,CARD_TYPE,CONTROL,TEMPLATE,ORDER_SEQ) VALUES ('CGST','Company & Group Setting','./#!/comgroupsetting','ADMN','Company & Group Setting','',null,null,null,'IMG', 'comgroupsetting','./views/comgroupsetting.tpl.jsp',2);
INSERT INTO MST_CARD (CODE,NAME,HREF,STEP,TITLE,DESCRIPTION,IMG,ICON,COLOR,CARD_TYPE,CONTROL,TEMPLATE,ORDER_SEQ) VALUES ('VWRL','View Role','./#!/cardviewrole','ADMN','View Role','',null,null,null,'IMG', 'cardviewrole','./views/cardviewrole.tpl.jsp',3);
INSERT INTO MST_CARD (CODE,NAME,HREF,STEP,TITLE,DESCRIPTION,IMG,ICON,COLOR,CARD_TYPE,CONTROL,TEMPLATE,ORDER_SEQ) VALUES ('ATRL','Action Role','./#!/actionrole','ADMN','Action Role','',null,null,null,'IMG', 'actionrole','./views/actionrole.tpl.jsp',4);
INSERT INTO MST_CARD (CODE,NAME,HREF,STEP,TITLE,DESCRIPTION,IMG,ICON,COLOR,CARD_TYPE,CONTROL,TEMPLATE,ORDER_SEQ) VALUES ('MSST','Data Master Setting',null,'ADMN','Data Master Setting','',null,null,null,'IMC', 'datamastersetting','./views/card.tpl.jsp',5);
INSERT INTO MST_CARD (CODE,NAME,HREF,STEP,TITLE,DESCRIPTION,IMG,ICON,COLOR,CARD_TYPE,CONTROL,TEMPLATE,ORDER_SEQ) VALUES ('CMST','Card Master Setting','./#!/cardmastersetting','MAST','Card Master Setting','',null,null,null,'IMG', 'cardmastersetting', './views/cardmastersetting.tpl.jsp',1);


INSERT INTO MST_ROLE (ROLE,NAME) VALUES ('CMCH','COMPANY CHANGE');
INSERT INTO MST_ROLE (ROLE,NAME) VALUES ('GRCH','GROUP CHANGE');