CREATE DATABASE IF NOT EXISTS tqr; 

USE tqr;

CREATE TABLE  IF NOT EXISTS `src_trm_application`(
  `cfk_trademark_gid` varchar(36) COMMENT 'The id that is assigned to a trademark application at the time of receipt at the Patent Trademark Office', 
  `serial_num_tx` varchar(8) COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.', 
  `filing_dt` date COMMENT 'The date on which all the elements set forth in 37 C.F.R. 2.21(a) (see TMEP 202) are received in the USPTO.', 
  `literal_element_tx` string COMMENT 'The text comprising the Literal Element', 
  `standard_character_tx` string COMMENT 'The text of a Design Mark if it is a standard character drawing.',
  `mark_description_tx` string COMMENT 'A complete description of the entire mark, including all literal elements and/or design elements that are found in the mark image, but NOT including any element not appearing in the image. If this is a color mark, the color(s) that are part of the mark must be stated, including black and white, and the location of the colors in the mark must be stated ', 
  `mark_drawing_type_cd` varchar(5) COMMENT 'Identifies the [Standard Mark Drawing Type] categorizing the [Trademark]', 
  `mark_drawing_type_title_tx` varchar(25) COMMENT 'A short descriptive name to identify the [Mark Drawing Type]', 
  `examiner_employee_no` varchar(7) COMMENT 'A unique number that is assigned by PTO to identify a specific worker.This is the examiners employee number. The examiner is the reviewee in quality review. Source: SDE', 
  `source_system_nm` varchar(100) COMMENT 'The source system used for online applying for a Trademark.  For example : TEAS Plus form, TEAS Reduced Fee form, TEAS Regular form .  <https://www.uspto.gov/trademarks-application-process/filing-online>', 
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.', 
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The Job Identifier of the job  that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
 )
COMMENT 'This table stores all trademark application level information. This table is populated from TRM database.'
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat' ;
  
CREATE TABLE  IF NOT EXISTS `src_fast_application_event`(
  `cfk_office_action_id` int  COMMENT 'The unique identifier for identifying the fast events',
  `serial_num_tx` varchar(8)  COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.',
  `transactional_literal_tx` varchar(250)  COMMENT 'The text comprising the fast action type',
  `review_type_ct` int  COMMENT 'Transaction Number represents the Transaction Literal..',
  `completed_ts` timestamp COMMENT 'The timestamp when event /  action was completed in the source system.',
  `examiner_employee_no` varchar(7) COMMENT 'A unique number that is assigned by PTO to identify a specific worker.This is the examiners employee number. The  examiner is the reviewee in quality review. Source: SDE',   
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The Job Identifier of the job  that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
  )
COMMENT 'This table stores the office actions of a trademark application. This table is populated from FAST database..'   
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat' ;  
  
CREATE TABLE  IF NOT EXISTS `src_trm_application_event`(
  `cfk_trademark_gid` varchar(36) COMMENT 'This is the TMNG Global Identifier that supports unique identification and reference of a [Trademark] throughout all TMNG applications.', 
  `business_event_id` int COMMENT 'Identifier for the business transaction which records the reason for a change to a trademark case.',
  `serial_num_tx` varchar(8) COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.', 
  `ckf_business_event_reason_id` int COMMENT 'System generated surrogate key field used to uniquely identify the [Business Event Reason].',
  `business_event_reason_cd` string COMMENT 'Code representing the description of why a particular action, i.e. Trademark Case Amendment, has  occurred.', 
  `effective_ts` timestamp COMMENT 'The business date on which the event occurred (with timestamp).', 
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The Job Identifier of the job  that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
  )
COMMENT 'This table stores PUB & SOU events associated with a trademark application. This table is populated from TRM database.'
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat' ;  

CREATE TABLE  IF NOT EXISTS `employee_organization`(
  `employee_no` varchar(7) COMMENT 'A unique number that is assigned by PTO to identify a specific worker.This is the examiners employee number. The examiner is the reviewee in quality review. Source: SDE', 
  `organization_cd` varchar(10) COMMENT 'The Organization assigned the quality review.  The Organization Code may include Law Office numbers.', 
  `status_ct` string COMMENT 'This status column indicates if the process of determining the organization code is completed or not. Possible values are completed, error.', 
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The Job Identifier of the job  that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
  )
COMMENT 'This table stores the law office number of employee (who is examiner).'   
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat';
  
CREATE TABLE  IF NOT EXISTS `application_search_present`(
  `serial_num_tx` varchar(8) COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.',
  `search_present_in` int COMMENT 'The search is done at the beginning of the TM examination and will not change over time.  We determine 1/0 if a search was done.  Although the contents of the search are captured in CMS, we are merely checking CMS to see if a search occurred.', 
  `status_ct` string COMMENT 'This status column indicates if the process of determining whether search present or not is completed or not. Possible values are completed and error.', 
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` string COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` string COMMENT 'The Job Identifier of the job  that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
  )
COMMENT 'This table stores the search indicator value of a trademark application.'   
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat';  

CREATE TABLE IF NOT EXISTS `event_inventory_stage`(
  `review_type_cd` varchar(15) COMMENT 'The unique code assigned to the review type.', 
  `serial_num_tx` varchar(8) COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.',
  `source_system_nm` varchar(100) COMMENT 'The source system used for online applying for a Trademark.  For example : TEAS Plus form, TEAS Reduced Fee form, TEAS Regular form .  <https://www.uspto.gov/trademarks-application-process/filing-online>',
  `search_present_in` int COMMENT 'The search is done at the beginning of the TM examination and will not change over time.  We determine 1/0 if a search was done.  Although the contents of the search are captured in CMS, we are merely checking CMS to see if a search occurred', 
  `source_event_dt` timestamp COMMENT 'The date when event/action was completed in the source system.', 
  `docket_in` int COMMENT 'The indicator that an inventory event is available on the docket.', 
  `mark_literal_element_tx` string COMMENT 'The text comprising the Literal Element', 
  `mark_drawing_type_cd` varchar(5)  COMMENT 'Identifies the [Standard Mark Drawing Type] categorizing the [Trademark]', 
  `mark_drawing_type_title_tx` varchar(25) COMMENT 'A short descriptive name to identify the [Mark Drawing Type]',   
  `mark_description_tx` string COMMENT 'A complete description of the entire mark, including all literal elements and/or design elements that are found in the mark image, but NOT including any element not appearing in the image. If this is a color mark, the color(s) that are part of the mark must be stated, including black and white, and the location of the colors in the mark must be stated ',   
  `examiner_employee_no` varchar(7) COMMENT 'A unique number that is assigned by PTO to identify a specific worker.This is the examiners employee number. The examiner is the reviewee in quality review. Source: SDE',  
  `organization_cd` varchar(10) COMMENT 'The Organization assigned the quality review.  The Organization Code may include Law Office numbers.', 
  `event_json_doc` string COMMENT 'The JSON document contain office action or transaction information from the source system filing basis, missinf data fields, and tagged elements', 
  `inventory_create_ts`     timestamp     COMMENT  'The date and time that the record is added to the docket.',
  `lock_control_no` int COMMENT 'A Number used to verify that the record being updated has not been altered since it was retrieved for update when optimistic locking is used. Upon insert, the Lock Control Number defaults to 1.' , 
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.' ,
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
  )
COMMENT 'This table stores the delta trademark events (first action, final action, pub and sou).'   
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat';  

CREATE TABLE IF NOT EXISTS `event_inventory`(
  `review_type_cd` varchar(15) COMMENT 'The unique code assigned to the review type.', 
  `serial_num_tx` varchar(8) COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.',
  `source_system_nm` varchar(100) COMMENT 'The source system used for online applying for a Trademark.  For example : TEAS Plus form, TEAS Reduced Fee form, TEAS Regular form .  <https://www.uspto.gov/trademarks-application-process/filing-online>',
  `search_present_in` int COMMENT 'The search is done at the beginning of the TM examination and will not change over time.  We determine 1/0 if a search was done.  Although the contents of the search are captured in CMS, we are merely checking CMS to see if a search occurred', 
  `source_event_dt` timestamp COMMENT 'The date when event/action was completed in the source system.', 
  `docket_in` int COMMENT 'The indicator that an inventory event is available on the docket.', 
  `mark_literal_element_tx` string COMMENT 'The text comprising the Literal Element', 
  `mark_drawing_type_cd` varchar(5)  COMMENT 'Identifies the [Standard Mark Drawing Type] categorizing the [Trademark]', 
  `mark_drawing_type_title_tx` varchar(25) COMMENT 'A short descriptive name to identify the [Mark Drawing Type]',   
  `mark_description_tx` string COMMENT 'A complete description of the entire mark, including all literal elements and/or design elements that are found in the mark image, but NOT including any element not appearing in the image. If this is a color mark, the color(s) that are part of the mark must be stated, including black and white, and the location of the colors in the mark must be stated ',   
  `examiner_employee_no` varchar(7) COMMENT 'A unique number that is assigned by PTO to identify a specific worker.This is the examiners employee number. The examiner is the reviewee in quality review. Source: SDE',  
  `organization_cd` varchar(10) COMMENT 'The Organization assigned the quality review.  The Organization Code may include Law Office numbers.', 
  `event_json_doc` string COMMENT 'The JSON document contain office action or transaction information from the source system filing basis, missinf data fields, and tagged elements', 
  `inventory_create_ts`     timestamp     COMMENT  'The date and time that the record is added to the docket.',
  `lock_control_no` int COMMENT 'A Number used to verify that the record being updated has not been altered since it was retrieved for update when optimistic locking is used. Upon insert, the Lock Control Number defaults to 1.' , 
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.' ,
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
  )
COMMENT 'This table stores the final trademark events data (first action, final action, pub, sou) after merged with staging table.'   
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat';
  
 CREATE TABLE  IF NOT EXISTS `job_log`(
  `job_nm` varchar(50) COMMENT 'stores the job name ',
  `start_ts` timestamp  COMMENT 'identifies when job started',
  `end_ts` timestamp COMMENT 'identifies when job ended',
  `status_ct` varchar(20) COMMENT 'status can be success,error or completed',
  `record_qt` int COMMENT 'identifies number of records inserted',
  `comment_tx` varchar(500) COMMENT 'stores additional comments for the job')
COMMENT 'This table stores the job log with the status of jobs.'   
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'  ;

CREATE TABLE IF NOT EXISTS `src_fast_tagged_element`(
  `serial_num_tx` varchar(8) COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.',
  `cfk_office_action_id` int COMMENT 'The unique identifier for identifying the fast events.', 
  `cfk_form_paragraph_category_id` int COMMENT 'Primary key of form paragraph category id.',  
  `form_paragraph_ct` varchar(100) COMMENT 'Form paragraph category name.',  
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.' 
  )
COMMENT 'This table stores the tagged elements associated with office action.'    
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat' ;
  
CREATE TABLE IF NOT EXISTS `tagged_element`(
  `cfk_tagged_element_id` int COMMENt 'Primary key of stnd_tagged_element (MySQL) table of TQR.',
  `tagged_element_nm` varchar(100) COMMENT 'The unique name of the tagged data element.  The current version of the MySQL database does not support unique constraint for case-insensitive data.', 
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.' 
  )
COMMENT 'The table maintains an ordered list of tagged data elements that can be displayed for an office action.'  
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' ;
    
CREATE TABLE  IF NOT EXISTS `tagged_element_mapping`(
  `form_paragraph_ct` string COMMENT 'Form paragraph category name.', 
  `cfk_tagged_element_id` int COMMENt 'Primary key of stnd_tagged_element (MySQL) table of TQR.',
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
  )
COMMENT 'This table stores the mapping of form paragraph names of FAST db with TQR tagged element names.'     
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'  ;  
  
 CREATE TABLE IF NOT EXISTS `job_control`(
  `job_nm` string COMMENT 'Job name (PUB, SOU, First Action and Final Action) that loads the events.', 
  `load_ts` timestamp  COMMENT 'Timestamp at which job got loaded for the given job name',
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
  )
COMMENT 'This table is a job control table that holds the timestamp of when the job run last time successfully.'  
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat' ;

CREATE TABLE  IF NOT EXISTS `src_trm_filing_basis`(
  `cfk_trademark_gid` varchar(36) COMMENT 'The id that is assigned to a trademark application at the time of receipt at the Patent Trademark Office', 
  `serial_num_tx` varchar(8) COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.', 
  `filing_basis_cd` varchar(5) COMMENT 'A unique code to identify the [Standard Filing Basis].The specific value that denotes the basis for filing a Trademark application.', 
  `current_in` string COMMENT 'Indicates the filing basis is current or not with possible value Y/N', 
  `amend_in` string COMMENT 'Indicates the filing basis is amended or not with possible value Y/N', 
  `file_in` string COMMENT 'Indicates the filing basis is filed or not with possible value Y/N', 
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.')
COMMENT 'This table stores filing basis codes for a serial_no'
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'  ;

CREATE TABLE  IF NOT EXISTS `tqr_detail_metrics`(
  `eventInventoryIdentifier` bigint COMMENT 'This uniquely identifies an instance of  a Quality Review Selected activity initiated by the Trademarks office in response to a filing or event.Identifier is from the event_inventory table in mysql.', 
  `qualityReviewIdentifier` bigint COMMENT 'This uniquely identifies an instance of a a review that is either in the docket or under quality review.Identifier is from the quality_review table in mysql.', 
  `reviewTypeCode` varchar(15) COMMENT 'The unique code assigned to the review type.It is only unique per revision number in the source.', 
  `trademarkSerialNumber`  varchar(8) COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.',
  `eventDateTime` timestamp COMMENT 'The date time when event /  action was completed in the source system.',  
  `examinerEmployeeNumber` varchar(7) COMMENT 'A unique number that is assigned by PTO to identify a specific worker.This is the examiners employee number. The examiner is the reviewee in quality review. ',
  `organizationCode` varchar(10) COMMENT 'The Organization assigned the quality review.  The Organization Code may include Law Office numbers.', 
  `searchCompleteIndicator` tinyint COMMENT 'Determine true/false if a search was done',
  `reviewerEmployeeNumber` varchar(7) COMMENT 'A unique number that is assigned by PTO to identify a specific worker. This is the employee number of the person who is reviewing a case under quality review.' ,
  `lastReviewDateTime` timestamp COMMENT 'last review happened timestamp', 
  `assignDateTime` timestamp  COMMENT 'The date the review status was assigned.', 
  `completeDateTime` timestamp  COMMENT 'The date the review status was completed.',
  `financialYear` bigint COMMENT 'The year in which the review  was completed.', 
  `financialQuarterNumber` bigint COMMENT 'The month in which the review  was completed.',  
  `missedTagElementNameBag` string COMMENT 'List all the Tagged Element Names which are marked as missed for a given qualityreviewid', 
  `newTagElementNameBag` string COMMENT 'List all the Tagged Element Names which are marked as new', 
  `unsoundTagElementNameBag` string COMMENT 'List all the Tagged Element Names which are marked as unsound', 
  `soundTagElementNameBag` string COMMENT 'List all the Tagged Element Names which are marked as  sound', 
  `evidenceDeficientTagElementNameBag` string COMMENT 'List all the Tagged Element Names which are marked Evidence as deficient', 
  `evidenceSatisfactoryTagElementNameBag` string COMMENT 'List all the Tagged Element Names which are marked Evidence as satisfactory', 
  `evidenceExcellentTagElementNameBag` string COMMENT 'List all the Tagged Element Names which are marked Evidence as excellent', 
  `writingDeficientTagElementNameBag` string COMMENT 'List all the Tagged Element Names which are marked writing as deficient', 
  `writingSatisfactoryTagElementNameBag` string COMMENT 'List all the Tagged Element Names which are marked writing as satisfactory', 
  `writingExcellentTagElementNameBag` string  COMMENT 'List all the Tagged Element Names which are marked writing as excellent', 
  `searchSufficientIndicator` boolean COMMENT 'contain search sufficient true or false for a given qualityreviewid', 
  `qualityMetricDeficientIndicator` boolean COMMENT 'contain quality metric deficient true or false for a given qualityreviewid', 
  `missIssueIndicator` boolean COMMENT 'contain missed issuestrue or false for a given qualityreviewid', 
  `newIssueIndicator` boolean COMMENT 'contain new issues deficient true or false for a given qualityreviewid', 
  `refusalUnsoundIndicator` boolean COMMENT 'contain refusals unsound  true or false for a given qualityreviewid', 
  `substantiveDeficientIndicator` boolean COMMENT 'contain substantive deficient true or false for a given qualityreviewid', 
  `proceduralDeficientIndicator` boolean COMMENT 'contain procedural deficient true or false for a given qualityreviewid', 
  `overallDeficientIndicator` boolean COMMENT 'contain overall deficient true or false for a given qualityreviewid', 
  `overallExcellentIndicator` boolean COMMENT 'contain overall excellent true or false for a given qualityreviewid', 
  `evidenceDeficientIndicator` boolean COMMENT 'contain evidence deficient true or false for a given qualityreviewid', 
  `evidenceSatisfactoryIndicator` boolean COMMENT 'contain evidence satisfactory true or false for a given qualityreviewid', 
  `evidenceExcellentIndicator` boolean COMMENT 'contain evidence excellent true or false for a given qualityreviewid', 
  `writingDeficientIndicator` boolean COMMENT 'contain  writing deficient true or false for a given qualityreviewid', 
  `writingSatisfactoryIndicator` boolean COMMENT 'contain writing satisfactory true or false for a given qualityreviewid', 
  `writingExcellentIndicator` boolean COMMENT 'contain writing excellent true or false for a given qualityreviewid',
  `createDateTime` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `createUserIdentifier` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `lastModifiedDateTime` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `lastModifiedUserIdentifier` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.')
COMMENT 'This table stores the review form data elements like serial_no,missed elements,reviewtype code ,taggedelements, various indicators related to excellence ,satisfactory and deficiency for a given review form. '   
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'  ;

CREATE TABLE IF NOT EXISTS `event_inventory_discarded`(
  `review_type_cd` varchar(15) COMMENT 'The unique code assigned to the review type.', 
  `serial_num_tx` varchar(8) COMMENT 'The number that is assigned to a trademark application at the time of receipt at the Patent Trademark Office.  The number is a composite number consisting of two fields:  Series Code and Number.',
  `source_system_nm` varchar(100) COMMENT 'The source system used for online applying for a Trademark.  For example : TEAS Plus form, TEAS Reduced Fee form, TEAS Regular form .  <https://www.uspto.gov/trademarks-application-process/filing-online>',
  `search_present_in` int COMMENT 'The search is done at the beginning of the TM examination and will not change over time.  We determine 1/0 if a search was done.  Although the contents of the search are captured in CMS, we are merely checking CMS to see if a search occurred', 
  `source_event_dt` timestamp COMMENT 'The date when event/action was completed in the source system.', 
  `docket_in` int COMMENT 'The indicator that an inventory event is available on the docket.', 
  `mark_literal_element_tx` string COMMENT 'The text comprising the Literal Element', 
  `mark_drawing_type_cd` varchar(5)  COMMENT 'Identifies the [Standard Mark Drawing Type] categorizing the [Trademark]', 
  `mark_drawing_type_title_tx` varchar(25) COMMENT 'A short descriptive name to identify the [Mark Drawing Type]',   
  `mark_description_tx` string COMMENT 'A complete description of the entire mark, including all literal elements and/or design elements that are found in the mark image, but NOT including any element not appearing in the image. If this is a color mark, the color(s) that are part of the mark must be stated, including black and white, and the location of the colors in the mark must be stated ',   
  `examiner_employee_no` varchar(7) COMMENT 'A unique number that is assigned by PTO to identify a specific worker.This is the examiners employee number. The examiner is the reviewee in quality review. Source: SDE',  
  `organization_cd` varchar(10) COMMENT 'The Organization assigned the quality review.  The Organization Code may include Law Office numbers.', 
  `event_json_doc` string COMMENT 'The JSON document contain office action or transaction information from the source system filing basis, missinf data fields, and tagged elements', 
  `inventory_create_ts`     timestamp     COMMENT  'The date and time that the record is added to the docket.',
  `lock_control_no` int COMMENT 'A Number used to verify that the record being updated has not been altered since it was retrieved for update when optimistic locking is used. Upon insert, the Lock Control Number defaults to 1.' , 
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.' ,
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'

  )
COMMENT 'This table stores the intervening trasactions data that are not stored in the event_inventory table (first action, final action, pub and sou).'   
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat';


CREATE TABLE IF NOT EXISTS `appmdr_dev`(
  'applicantfilereference'  STRING  COMMENT 'An identifier assigned by a non-PTO interest to the patent case',            
  'applicationdeemedwithdrawndate'  STRING  COMMENT 'The date that the application is currently abandoned.   An application can be abandoned more than once.   The history of abandonments is recorded in Patent Case Action.',            
  'applicationstatusnumber' BIGINT  COMMENT 'A character string that uniquely identifies the Application Patent Case among others that are either US domestic or international applications.',             
  'applicationtypecategory' STRING  COMMENT 'The nature of the patent application submission relative to the action requested of the patent office.',            
  'businessentitystatuscategory'  STRING  COMMENT 'Means an independent inventor, a small business concern, or a nonprofit organization eligible for reduced patent fees',          
  'customernumber'  BIGINT  COMMENT 'Customer number for correspondence.',           
  'effectiveclaimtotalquantity' BIGINT  COMMENT 'The total number of claims for which the USPTO can charge a fee for a specific patent application.',            
  'effectivefilingdate' STRING  COMMENT 'The date according to PTO criteria that the patent case qualified as having been filed.  The effective filing date is the same or later than the Filing Date.  The filing date can be changed due to a subsequent action on an application patent case.',           
  'examinationprogramcode'  STRING  COMMENT 'Examination program code like AE, AIA, FTI etc. or user defined code',         
  'examineremployeenumber'  STRING  COMMENT 'The name of Author who contributes to the cited non-patent literature (NPL).',            
  'figurequantity'  BIGINT  COMMENT 'This attribute contains the total number of sheets (pages) of drawing for a particular patent application. Each sheet contains one or more figures. This information is provided by the applicant.',           
  'filingdate'  STRING  COMMENT 'The date according to PTO criteria that the patent case qualified as having been filed.  The effective filing date is the same or later than the Filing Date.  The filing date can be changed due to a subsequent action on an application patent case.',           
  'grantdate' STRING  COMMENT 'Date on which the patent was granted.',           
  'groupartunitnumber'  BIGINT  COMMENT 'A number assigned to "GAU" a working unit responsible for a cluster of related patent art. Staffed by one supervisory patent examiner (SPE) and a number of patent examiners who determine patentability on applications for a patent. Group Art Units are currently identified by a four digit number, i.e., 1642.?',           
  'id'  STRING  COMMENT 'unique identifier',          
  'independentclaimtotalquantity' BIGINT  COMMENT 'The total number of independent claims for an invention',          
  'inventionsubjectmattercategory'  STRING  COMMENT 'A classification of the basic subject matter of the invention as one of the following ',          
  'inventiontitle'  STRING  COMMENT 'The title of the invention within the patent case.',          
  'nsrdcurrentlocationdate' STRING  COMMENT 'The date that the physical object was recorded at the current PTO location.',         
  'nsrdcurrentlocationnumber' STRING  COMMENT 'The PTO location that has the physical object. An application generated internal number that  uniquely identifies a PTO Location.',            
  'nationalclass' STRING  COMMENT First 'level national classification ',          
  'nationalsubclass' STRING  COMMENT 'Second Level National Classification',           
  'patentapplicationconfirmationnumber' BIGINT  COMMENT 'The confirmation number of the office action posting.',           
  'patentapplicationnumber' STRING  COMMENT 'The unique number assigned to a patent application when it is filed. The application number includes a two digit series code and a six digit serial number',
  'patentapplicationpatentcooperationtreatynumber'  STRING  COMMENT 'Patent Cooperation Treaty provides a mechanism by which an applicant can file a single application that is equivalent to a regular national filing in each designated Contracting State',           
  'patentnumber'  STRING  COMMENT 'Unique number assigned to a patent application when it issues as a patent.',           
  'priorityclaimindicator'  STRING  COMMENT 'The specific value that denotes the published non-U.S. reference is being used to request an early filing priority for a specific patent application',          
  'priorityclaimrequirementmetindicator'  STRING  COMMENT 'Benefit of earlier filing date right of priority',
  'relateddocumentcategory' STRING  COMMENT 'A code that denotes the patent application ancestry. That is, whether the patent application is spun off another patent application',             
  'techcenter'  STRING  COMMENT 'tech center',          
  'workgroup' STRING  COMMENT 'workgroup',
  'publicindicator' BOOLEAN COMMENT 'Pubilc indicator status',
  `create_ts` timestamp COMMENT 'The date and time that entity is inserted in the database.', 
  `create_user_id` varchar(36) COMMENT 'The Job Identifier of the job that initiated the insert of the entity into the database.',
  `last_mod_ts` timestamp COMMENT 'The date and time that entity was last modified in the database.  Upon creation, this will be the same as the Create Timestamp.', 
  `last_mod_user_id` varchar(36) COMMENT 'The User Identifier of the logged-on User that initiated the update of the entity into the database. Upon creation, this will be the same as the Create User Identifier.'
          
  )
COMMENT 'This table stores the public indicator status'
  'org.apache.hadoop.hive.ql.io.orc.OrcSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat';

