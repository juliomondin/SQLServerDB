
/*Insert one country code*/
USE [GLASS_LEWIS];
INSERT INTO GL_LIST_COUNTRY_CODES (CONTINENT, COUNTRY, COUNTRY_SHORT, A2, A3, ACTIVE)
VALUES ('Asia', 'Afghanistan', 'Afg', 'AF', 'AFG', 1)

USE [GLP];
insert into UM_Roles values ( 'All Acess User', 'Allows complete read and write permissions to all role functions.','GL',0,getdate(),null,0);
insert into UM_User(UserFirstName,LoginID,UserPassword,ContactEmail,UserClassCode,StatusCode,DeletedFlag,LastModifiedBy,LastModifiedDate,RoleID,UserRoleTypeID,AnswerSecurityQuestionsAttempts,
AnswerSecurityQuestions,AllVotingGroupsSelected,LoginType) values('Automation QaUat','automation@glasslewis.com', '503EF00FF48228E6F8E3DB71C7CC3BCBFF165DF6','Neubergerinternal@glasslewis.com','GlassLewis',1,0, 0, getdate(),1,3,0,0,0,1);

