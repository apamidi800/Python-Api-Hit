--DEAL Test Product LUP
   Real time view of goals/standard metrics for testing.Replicate Excel Monthly Documents for Retrieve, LP, Homepage.Scorecard Tab (Recreate Excel): Goal Metrics, Device Breakout, Lift over Holdout by Test (true holdout)
    Test Tab: Get granular with each test -- lift over Test Control (specific to test), lift over True Holdout (disjoint group 1)
    LUP/v by E1 segment 
    LUP/v by product 


     
     
     --DID NOT INCLUDE "DID USER SEE HOMEPAGE TEST" --RETURNVISITORPOSTTEST

--DATES - 'TEST DATES', DATES FOR "DID USER SEE HOMEPAGE BEFORE TEST LAUNCHED"
SET (startdate, enddate, pre_startdate, pre_startdate2, pagetype )  = 
(
  '2025-01-28' --startdate
 ,'2025-01-31' --enddate --10-29
 ,dateadd(day, -2, '2025-01-28') --,dateadd(day, -90, $startdate) --pre_startdate --90 days before startdate?
 ,dateadd(day, -1, '2025-01-28') --,dateadd(day, -1, $startdate) --pre_startdate2 --1 day before startdate
 ,'Home Page' --'Home Page' or 'Landing Page' (Also use Landing Page for Retrieve)
);

--DACQ_EXP.TARGET.FACTQUOTESTARTLUPVALUES --LUP Table

WITH factmarketingchannelsummary as (
    SELECT
        --*
        FACTSITEHITID,
        FACTVISITID,
        CASE
          WHEN (FACTVISITID_MKTG_DOW IS NULL OR FACTVISITID_MKTG_DOW = '') THEN CAST(FACTVISITID AS VARCHAR)
          ELSE CAST(FACTVISITID_MKTG_DOW AS VARCHAR)
        END AS FACTVISITID_MKTG_DOW,
        MARKETINGCHANNELMETHODNAME_DOW,
        SEQUENCEWITHINVISITNBR,
        PARTITIONDATE
    FROM
        DACQ_EXP.TARGET.FACTMARKETINGCHANNELSUMMARY_20240910_24
    WHERE
        partitiondate BETWEEN $startdate AND $enddate
),

factquotestartlupvalues as (
  SELECT *
  FROM DACQ_EXP.TARGET.FACTQUOTESTARTLUPVALUES
  WHERE page_type = $pagetype
)

SELECT
  --should we add partnercode? question for Eric/Kelly --ADDED PLACEHOLDER
  TO_CHAR(date_, 'YYYYMMDD') AS date_
  --LEFT(test, (LEN(SPLIT_PART(test,'=',1))+2)) AS test_ --removes test variant name, just leaves variant letter
  ,test
  ,device
  ,nsseg
  ,0 AS returnvisitor --placeholder til i verify logic is working properly
  ,SUM(LUP) AS LUP_
  ,SUM(cnt) AS visits
  ,SUM(QS_) AS QS__
  ,SUM(QR_) AS QR__
  ,SUM(AUQS_LUP) AS AUQS_LUP_
  ,SUM(AUQR_LUP) AS AUQR_LUP_
  ,SUM(AUCOQS_LUP) AS AUCOQS_LUP_
  ,SUM(AUHOQS_LUP) AS AUHOQS_LUP_
  ,SUM(AURTQS_LUP) AS AURTQS_LUP_
  ,SUM(BTQS_LUP) AS BTQS_LUP_
  ,SUM(BTQR_LUP) AS BTQR_LUP_
  ,SUM(CQS_LUP) AS CQS_LUP_
  ,SUM(CAQS_LUP) AS CAQS_LUP_
  ,SUM(CAQR_LUP) AS CAQR_LUP_
  ,SUM(CCQS_LUP) AS CCQS_LUP_
  ,SUM(DEQS_LUP) AS DEQS_LUP_
  ,SUM(EDQS_LUP) AS EDQS_LUP_
  ,SUM(HQS_LUP) AS HQS_LUP_
  ,SUM(BoltQR_LUP) AS BoltQR_LUP_
  ,SUM(HomesiteQR_LUP) AS HomesiteQR_LUP_
  ,SUM(HEQS_LUP) AS HEQS_LUP_
  ,SUM(HSQS_LUP) AS HSQS_LUP_
  ,SUM(HWQS_LUP) AS HWQS_LUP_
  ,SUM(IDQS_LUP) AS IDQS_LUP_
  ,SUM(IDCQS_LUP) AS IDCQS_LUP_
  ,SUM(IDCCQS_LUP) AS IDCCQS_LUP_
  ,SUM(IDEQS_LUP) AS IDEQS_LUP_
  ,SUM(IDECQS_LUP) AS IDECQS_LUP_
  ,SUM(LQS_LUP) AS LQS_LUP_
  ,SUM(LFQS_LUP) AS LFQS_LUP_
  ,SUM(LPQS_LUP) AS LPQS_LUP_
  ,SUM(LUQS_LUP) AS LUQS_LUP_
  ,SUM(LWQS_LUP) AS LWQS_LUP_
  ,SUM(MXQS_LUP) AS MXQS_LUP_
  ,SUM(MCQS_LUP) AS MCQS_LUP_
  ,SUM(MCQR_LUP) AS MCQR_LUP_
  ,SUM(MEQS_LUP) AS MEQS_LUP_
  ,SUM(MHQS_LUP) AS MHQS_LUP_
  ,SUM(PQS_LUP) AS PQS_LUP_
  ,SUM(PRQS_LUP) AS PRQS_LUP_
  ,SUM(RQS_LUP) AS RQS_LUP_
  ,SUM(ASIQR_LUP) AS ASIQR_LUP_
  ,SUM(RVQS_LUP) AS RVQS_LUP_
  ,SUM(MTQR_LUP) AS MTQR_LUP_
  ,SUM(TTQR_LUP) AS TTQR_LUP_
  ,SUM(SHQS_LUP) AS SHQS_LUP_
  ,SUM(SMQS_LUP) AS SMQS_LUP_
  ,SUM(SMQR_LUP) AS SMQR_LUP_
  ,SUM(SWQS_LUP) AS SWQS_LUP_
  ,SUM(TCQS_LUP) AS TCQS_LUP_ --not on spreadsheet version
  ,SUM(TRQS_LUP) AS TRQS_LUP_
  ,SUM(UMQS_LUP) AS UMQS_LUP_
  ,SUM(VIQS_LUP) AS VIQS_LUP_
  ,SUM(WEQS_LUP) AS WEQS_LUP_
  ,SUM(LOGIN_LUP) AS LOGIN_LUP_
  ,SUM(FAA_LUP) AS FAA_LUP_
  ,'' AS partnercode
FROM
  ( --createlup
    SELECT        
      fullV
      ,V
      ,date_
      -- ,monetatehittime
      ,device
      ,nsseg
      -- ,homepagefirstpage
      ,test
      -- ,monetatetesterror
      -- ,multvarianterror
      -- ,returnvisit_posttest
      -- ,returnvisitor_pretest
      
      ,GREATEST(AUQS_LUP, AUQR_LUP, AUCOQS_LUP, AUHOQS_LUP, AURTQS_LUP, BTQS_LUP, BTQR_LUP, CQS_LUP, CAQS_LUP, CAQR_LUP, CCQS_LUP, DEQS_LUP, EDQS_LUP, HQS_LUP, BoltQR_LUP, HomesiteQR_LUP, HEQS_LUP, HSQS_LUP, HWQS_LUP, IDQS_LUP, IDCQS_LUP, IDCCQS_LUP, IDEQS_LUP, IDECQS_LUP, LQS_LUP, LFQS_LUP, LPQS_LUP, LUQS_LUP, LWQS_LUP, MXQS_LUP, MCQS_LUP, MCQR_LUP, MEQS_LUP, MHQS_LUP, PQS_LUP, PRQS_LUP, RQS_LUP, ASIQR_LUP, RVQS_LUP, MTQR_LUP, TTQR_LUP, SHQS_LUP, SMQS_LUP, SMQR_LUP, SWQS_LUP, TCQS_LUP, TRQS_LUP, UMQS_LUP, VIQS_LUP, WEQS_LUP, LOGIN_LUP, FAA_LUP) AS LUP
      
      ,(AUQS_LUP + AUQR_LUP + AUCOQS_LUP + AUHOQS_LUP + AURTQS_LUP + BTQS_LUP + BTQR_LUP + CQS_LUP + CAQS_LUP + CAQR_LUP + CCQS_LUP + DEQS_LUP + EDQS_LUP + HQS_LUP + BoltQR_LUP + HomesiteQR_LUP + HEQS_LUP + HSQS_LUP + HWQS_LUP + IDQS_LUP + IDCQS_LUP + IDCCQS_LUP + IDEQS_LUP + IDECQS_LUP + LQS_LUP + LFQS_LUP + LPQS_LUP + LUQS_LUP + LWQS_LUP + MXQS_LUP + MCQS_LUP + MCQR_LUP + MEQS_LUP + MHQS_LUP + PQS_LUP + PRQS_LUP + RQS_LUP + ASIQR_LUP + RVQS_LUP + MTQR_LUP + TTQR_LUP + SHQS_LUP + SMQS_LUP + SMQR_LUP + SWQS_LUP + TCQS_LUP + TRQS_LUP + UMQS_LUP + VIQS_LUP + WEQS_LUP + LOGIN_LUP + FAA_LUP ) AS LUP2
      
      ,cnt
      ,QS_
      ,QR_
      ,AUQS_LUP
      ,AUQR_LUP
      ,AUCOQS_LUP
      ,AUHOQS_LUP
      ,AURTQS_LUP
      ,BTQS_LUP
      ,BTQR_LUP
      ,CQS_LUP
      ,CAQS_LUP
      ,CAQR_LUP
      ,CCQS_LUP
      ,DEQS_LUP
      ,EDQS_LUP
      ,HQS_LUP
      ,BoltQR_LUP
      ,HomesiteQR_LUP
      ,HEQS_LUP
      ,HSQS_LUP
      ,HWQS_LUP
      ,IDQS_LUP
      ,IDCQS_LUP
      ,IDCCQS_LUP
      ,IDEQS_LUP
      ,IDECQS_LUP
      ,LQS_LUP
      ,LFQS_LUP
      ,LPQS_LUP
      ,LUQS_LUP
      ,LWQS_LUP
      ,MXQS_LUP
      ,MCQS_LUP
      ,MCQR_LUP
      ,MEQS_LUP
      ,MHQS_LUP
      ,PQS_LUP
      ,PRQS_LUP
      ,RQS_LUP
      ,ASIQR_LUP
      ,RVQS_LUP
      ,MTQR_LUP
      ,TTQR_LUP
      ,SHQS_LUP
      ,SMQS_LUP
      ,SMQR_LUP
      ,SWQS_LUP
      ,TCQS_LUP --not on spreadsheet version
      ,TRQS_LUP
      ,UMQS_LUP
      ,VIQS_LUP
      ,WEQS_LUP
      ,LOGIN_LUP
      ,FAA_LUP
    FROM
      ( --LUPCalc
        SELECT
          fullV,
          V,
          date_,
          --monetatehittime,
          device,
          nsseg,
          homepagefirstpage,
          test,
          monetatetesterror,
          multvarianterror,
          -- loginsecondpage,
          -- returnvisit_posttest,
          returnvisitor_pretest,
          1 AS cnt,
          QS_,
          QR_,

          CASE
            WHEN AUQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AUQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN AUQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AUQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS AUQS_LUP,

          CASE
            WHEN AUQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AUQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN AUQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AUQR'  AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS AUQR_LUP,

          CASE
            WHEN AUCOQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AUCOQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN AUCOQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AUCOQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS AUCOQS_LUP,

          CASE
            WHEN AUHOQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AUHOQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN AUHOQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AUHOQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS AUHOQS_LUP,

          CASE
            WHEN AURTQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AURTQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN AURTQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'AURTQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS AURTQS_LUP,

          CASE
            WHEN BTQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'BTQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN BTQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'BTQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS BTQS_LUP,

          CASE
            WHEN BTQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'BTQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN BTQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'BTQR' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS BTQR_LUP,

          CASE
            WHEN CQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'CQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN CQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'CQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS CQS_LUP,

          CASE
            WHEN CAQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'CAQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN CAQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'CAQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS CAQS_LUP,

          CASE
            WHEN CAQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'CAQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN CAQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'CAQR' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS CAQR_LUP,

          CASE
            WHEN CCQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'CCQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN CCQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'CCQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS CCQS_LUP,

          CASE
            WHEN DEQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'DEQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN DEQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'DEQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS DEQS_LUP,

          CASE
            WHEN EDQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'EDQS'AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN EDQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'EDQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS EDQS_LUP,

          CASE
            WHEN HQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN HQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS HQS_LUP,

          CASE
            WHEN BoltQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'BoltQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN BoltQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'BoltQR' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS BoltQR_LUP,

          CASE
            WHEN HomesiteQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HomesiteQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN HomesiteQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HomesiteQR' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS HomesiteQR_LUP,

          CASE
            WHEN HEQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HEQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN HEQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HEQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS HEQS_LUP,

          CASE
            WHEN HSQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HSQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN HSQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HSQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS HSQS_LUP,

          CASE
            WHEN HWQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HWQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN HWQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'HWQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS HWQS_LUP,

          CASE
            WHEN IDQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN IDQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS IDQS_LUP,

          CASE
            WHEN IDCQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDCQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN IDCQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDCQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS IDCQS_LUP,

          CASE
            WHEN IDCCQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDCCQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN IDCCQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDCCQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS IDCCQS_LUP,

          CASE
            WHEN IDEQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDEQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN IDEQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDEQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS IDEQS_LUP,

          CASE
            WHEN IDECQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDECQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN IDECQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'IDECQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS IDECQS_LUP,

          CASE
            WHEN LQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN LQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS LQS_LUP,
  
          CASE
            WHEN LFQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LFQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN LFQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LFQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS LFQS_LUP,

          CASE
            WHEN LPQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LPQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN LPQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LPQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS LPQS_LUP,

          CASE
            WHEN LUQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LUQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN LUQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LUQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS LUQS_LUP,
          
          CASE
            WHEN LWQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LWQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN LWQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LWQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS LWQS_LUP,

          CASE
            WHEN MXQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MXQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN MXQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MXQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS MXQS_LUP,

          CASE
            WHEN MCQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MCQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN MCQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MCQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS MCQS_LUP,

          CASE
            WHEN MCQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MCQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN MCQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MCQR' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS MCQR_LUP,

          CASE
            WHEN MEQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MEQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN MEQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MEQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS MEQS_LUP,

          CASE
            WHEN MHQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MHQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN MHQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MHQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS MHQS_LUP,

          CASE
            WHEN PQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'PQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN PQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'PQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS PQS_LUP,
          
          CASE
            WHEN PRQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'PRQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN PRQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'PRQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS PRQS_LUP,

          CASE
            WHEN RQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'RQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN RQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'RQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS RQS_LUP,

          CASE
            WHEN ASIQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'ASIQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN ASIQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'ASIQR' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS ASIQR_LUP,

          CASE
            WHEN RVQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'RVQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN RVQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'RVQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS RVQS_LUP, 

          CASE
            WHEN MTQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MTQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN MTQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'MTQR' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS MTQR_LUP,
          
          CASE
            WHEN TCQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'TCQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN TCQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'TCQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS TCQS_LUP,

          CASE
            WHEN TTQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'TTQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN TTQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'TTQR' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS TTQR_LUP,

          CASE
            WHEN SHQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'SHQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN SHQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'SHQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS SHQS_LUP,

          CASE
            WHEN SMQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'SMQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN SMQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'SMQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS SMQS_LUP,

          CASE
            WHEN SMQR_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'SMQR' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN SMQR_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'SMQR' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS SMQR_LUP,

          CASE
            WHEN SWQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'SWQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN SWQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'SWQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS SWQS_LUP,

          CASE
            WHEN TRQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'TRQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN TRQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'TRQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS TRQS_LUP,

          CASE
            WHEN UMQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'UMQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN UMQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'UMQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS UMQS_LUP,

          CASE
            WHEN VIQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'VIQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN VIQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'VIQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS VIQS_LUP,

          CASE
            WHEN WEQS_ = 1 AND device = 'Mobile' THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'WEQS' AND factquotestartlupvalues.devicecategoryname = 'Mobile' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            WHEN WEQS_ = 1 AND device != 'Mobile' THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'WEQS' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_)
            ELSE 0
          END AS WEQS_LUP,

          CASE
            WHEN (LOGIN_ = 1 OR ezpay_ = 1 ) THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LOGIN' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_) --JUST USE DESKTOP VALUE, MOBILE AND DESKTOP ARE SAME
            WHEN (LOGIN_ = 0  AND loginsecondpage = 1) THEN
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'LOGIN' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_) --JUST USE DESKTOP VALUE, MOBILE AND DESKTOP ARE SAME
            ELSE 0
          END AS LOGIN_LUP,

          CASE
            WHEN FAA_ = 1 THEN 
              (SELECT VALUATION_AMOUNT FROM factquotestartlupvalues WHERE factquotestartlupvalues.metric = 'FAA' AND factquotestartlupvalues.devicecategoryname = 'Desktop' AND factquotestartlupvalues.start_dt <= date_ AND factquotestartlupvalues.end_dt >= date_) --JUST USE DESKTOP VALUE, MOBILE AND DESKTOP ARE SAME
            ELSE 0
          END AS FAA_LUP
          
        FROM
          ( --maxevents
            SELECT
              fullV,
              V,
              date_,
              monetatehittime,
              device,
              nsseg,
              homepagefirstpage,
              test,
              monetatetesterror,
              multvarianterror,
              loginsecondpage,
              --returnvisit_posttest,
              returnvisitor_pretest,
              MAX(QS) AS QS_,
              MAX(QR) AS QR_,
              MAX(AUQS) AS AUQS_,
              MAX(AUQR) AS AUQR_,
              MAX(AUCOQS) AS AUCOQS_,
              MAX(AUHOQS) AS AUHOQS_,
              MAX(AURTQS) AS AURTQS_,
              MAX(BTQS) AS BTQS_,
              MAX(BTQR) AS BTQR_,
              MAX(CQS) AS CQS_,
              MAX(CAQS) AS CAQS_,
              MAX(CAQR) AS CAQR_,
              MAX(CCQS) AS CCQS_,
              MAX(DEQS) AS DEQS_,
              MAX(EDQS) AS EDQS_,
              MAX(HQS) AS HQS_,
              MAX(BoltQR) AS BoltQR_,
              MAX(HomesiteQR) AS HomesiteQR_,
              MAX(HEQS) AS HEQS_,
              MAX(HSQS) AS HSQS_,
              MAX(HWQS) AS HWQS_,
              MAX(IDQS) AS IDQS_,
              MAX(IDCQS) AS IDCQS_,
              MAX(IDCCQS) AS IDCCQS_,
              MAX(IDEQS) AS IDEQS_,
              MAX(IDECQS) AS IDECQS_,
              MAX(LQS) AS LQS_,
              MAX(LFQS) AS LFQS_,
              MAX(LPQS) AS LPQS_,
              MAX(LUQS) AS LUQS_,
              MAX(LWQS) AS LWQS_,
              MAX(MXQS) AS MXQS_,
              MAX(MCQS) AS MCQS_,
              MAX(MCQR) AS MCQR_,
              MAX(MEQS) AS MEQS_,
              MAX(MHQS) AS MHQS_,
              MAX(PQS) AS PQS_,
              MAX(PRQS) AS PRQS_,
              MAX(RQS) AS RQS_,
              MAX(ASIQR) AS ASIQR_,
              MAX(RVQS) AS RVQS_,
              MAX(MTQR) AS MTQR_,
              MAX(TTQR) AS TTQR_,
              MAX(SHQS) AS SHQS_,
              MAX(SMQS) AS SMQS_,
              MAX(SMQR) AS SMQR_,
              MAX(SWQS) AS SWQS_,
              MAX(TCQS) AS TCQS_,
              MAX(TRQS) AS TRQS_,
              MAX(UMQS) AS UMQS_,
              MAX(VIQS) AS VIQS_,
              MAX(WEQS) AS WEQS_,
              MAX(LOGIN) AS LOGIN_,
              MAX(EZPAY) AS EZPAY_,
              MAX(FAA) AS FAA_
            FROM
              ( --main

                SELECT
                  fullV,
                   V,
                   date_,
                   monetatehittime,
                   device,
                   nsseg,
                   test,
                   IFNULL(homepagefirstpage_, 0) AS homepagefirstpage,
                   IFNULL(testerror,0) AS monetatetesterror,
                   IFNULL(multvarianterror_,0) AS multvarianterror,
                   IFNULL(loginsecondpage_,0) AS loginsecondpage,
                   --IFNULL(homepage_visit_beforetest,0) AS homepage_visit_beforetest,
                   --IFNULL(otherpage_visit_beforetest,0) AS otherpage_visit_beforetest,
                   IFNULL(returnvisitor_pretest_,'0') AS returnvisitor_pretest, --to numeric?
               
                   CASE
                     WHEN event_time >= monetatehittime AND (event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') THEN 1
                     ELSE 0
                   END AS qs,
                   -- quote retrieve all
                   CASE
                     WHEN event_time >= monetatehittime AND (event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success') THEN 1 --QuoteRetrieve-Success for /home-retrieve
                     ELSE 0
                   END AS qr,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'AU') THEN 1
                     ELSE 0
                   END AS AUQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success') AND event_label = 'AU') THEN 1 --OR QuoteRetrieve-Success
                     ELSE 0
                   END AS AUQR,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label IN ('AUCO','AU+CO','AUC','AU+C')) THEN 1
                     ELSE 0
                   END AS AUCOQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label IN ('AUHO','AU+HO','AUH','AU+H')) THEN 1
                     ELSE 0
                   END AS AUHOQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label IN ('AURT','AU+RT','AUR','AU+R')) THEN 1
                     ELSE 0
                   END AS AURTQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'BT') THEN 1
                     ELSE 0
                   END AS BTQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success') AND event_label = 'BT') THEN 1 --OR QuoteRetrieve-Success
                     ELSE 0
                   END AS BTQR,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'C') THEN 1 --add 'CO'?
                     ELSE 0
                   END AS CQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall')
                       AND (event_label = 'CA' OR event_label = 'GL' OR event_label = 'BO' OR event_label = 'BI' OR event_label = 'PL' OR event_label = 'CY' OR event_label = 'WC') ) THEN 1
                     ELSE 0
                   END AS CAQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'CA') THEN 1 --OR QuoteRetrieve-Success
                     ELSE 0
                   END AS CAQR,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'CC') THEN 1
                     ELSE 0
                   END AS CCQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'DE') THEN 1
                     ELSE 0
                   END AS DEQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'ED') THEN 1
                     ELSE 0
                   END AS EDQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'H') THEN 1
                     ELSE 0
                   END AS HQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success')
                       AND (event_label = 'bolt' OR event_label = 'QuoteNumber-Bolt' OR event_label = 'QuoteNumber-Bolt-H' OR event_label = 'QuoteNumber-Bolt-C' OR event_label = 'QuoteNumber-Bolt-R' )) THEN 1
                     ELSE 0
                   END AS BoltQR,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success')
                       AND (event_label = 'homesite' OR event_label = 'QuoteNumber-Homesite' OR event_label = 'QuoteNumber-Homesite-H' OR event_label = 'QuoteNumber-Homesite-C' OR event_label = 'QuoteNumber-Homesite-R')) THEN 1
                     ELSE 0
                   END AS HomesiteQR,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'HE') THEN 1
                     ELSE 0
                   END AS HEQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'HS') THEN 1
                     ELSE 0
                   END AS HSQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'HW') THEN 1
                     ELSE 0
                   END AS HWQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'ID') THEN 1
                     ELSE 0
                   END AS IDQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'ID-C') THEN 1
                     ELSE 0
                   END AS IDCQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'ID-CC') THEN 1
                     ELSE 0
                   END AS IDCCQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'ID-E') THEN 1
                     ELSE 0
                   END AS IDEQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'ID-EC') THEN 1
                     ELSE 0
                   END AS IDECQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'L') THEN 1
                     ELSE 0
                   END AS LQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'LF') THEN 1
                     ELSE 0
                   END AS LFQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'LP') THEN 1
                     ELSE 0
                   END AS LPQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'LU') THEN 1
                     ELSE 0
                   END AS LUQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'LW') THEN 1
                     ELSE 0
                   END AS LWQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'MX') THEN 1
                     ELSE 0
                   END AS MXQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label LIKE 'MC%') THEN 1
                     ELSE 0
                   END AS MCQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success') AND event_label LIKE 'MC%') THEN 1
                     ELSE 0
                   END AS MCQR,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'ME') THEN 1
                     ELSE 0
                   END AS MEQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'MH') THEN 1
                     ELSE 0
                   END AS MHQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'P') THEN 1
                     ELSE 0
                   END AS PQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'PR') THEN 1
                     ELSE 0
                   END AS PRQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'R') THEN 1
                     ELSE 0
                   END AS RQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success') AND (event_label = 'QuoteNumber-ASI' OR event_label = 'asi')) THEN 1
                     ELSE 0
                   END AS ASIQR,
                   CASE
                     WHEN event_time >= monetatehittime AND (
                          ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'TT')
                       OR ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'MT')
                       OR ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'RV')) THEN 1
                     ELSE 0
                   END AS RVQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success') AND event_label = 'MT') THEN 1
                     ELSE 0
                   END AS MTQR,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success') AND event_label = 'TT') THEN 1
                     ELSE 0
                   END AS TTQR,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'SH') THEN 1
                     ELSE 0
                   END AS SHQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'SM') THEN 1
                     ELSE 0
                   END AS SMQS,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteRetrieve' OR event_action = 'QuoteRetrieve-Success') AND event_label = 'SM') THEN 1
                     ELSE 0
                   END AS SMQR,
                   CASE
                     WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'SW') THEN 1
                     ELSE 0
                   END AS SWQS,
                   CASE
                     WHEN event_time >= monetatehittime
                       AND (((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'CB')
                         OR ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'CS')
                         OR ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'TC')) THEN 1
                     ELSE 0
                   END AS TCQS,
                   CASE
                      WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'TR') THEN 1
                      ELSE 0
                    END AS TRQS,
                   CASE
                      WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'UM') THEN 1
                      ELSE 0
                    END AS UMQS,
                   CASE
                      WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'VI') THEN 1
                      ELSE 0
                    END AS VIQS,
                   CASE
                      WHEN event_time >= monetatehittime AND ((event_action = 'QuoteStart' OR event_action = 'QuoteStart-ApiCall') AND event_label = 'WE') THEN 1
                      ELSE 0
                   END AS WEQS,
                   -- login
                   CASE
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'LinkClick' AND LOWER(event_label) IN ('login','log in')) THEN 1
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'ButtonClick' AND LOWER(event_label) IN ('login','log in')) THEN 1
                     ELSE 0
                   END AS LOGIN,
                   -- ezpay
                   CASE
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'LinkClick' AND event_label = 'ezpay') THEN 1
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'ButtonClick' AND event_label = 'ezpay') THEN 1
                     ELSE 0
                   END AS EZPAY,
                   -- find an agent
                   --ADD "findanagentonline" which is logging in answers
                   CASE
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'LinkClick' AND event_label = 'faa') THEN 1
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'LinkClick' AND event_label = 'findagent') THEN 1
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'LinkClick' AND event_label = 'FAA') THEN 1
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'LinkClick' AND event_label = 'findanagent') THEN 1
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'LinkClick' AND event_label = 'findanagentonline') THEN 1
                     ELSE 0
                   END AS FAA,
                   -- Mobile phone
                   CASE
                     --DW --NEED TO FIGURE OUT THIS REGEX FOR PHONE NUMBER
                     --WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'LinkClick' AND REGEXP_MATCH(event_label,r'^[0-9-]')) THEN 1
                     WHEN event_time >= monetatehittime AND (event_category = 'progCom' AND event_action = 'LinkClick' AND event_label = 'contactus') THEN 1
                     ELSE 0
                   END AS phone
                 FROM
                   ( --INITIAL
                     SELECT
                         fsh.VISITORID AS fullV
                         ,fmc.FACTVISITID_MKTG_DOW AS V
                         --,fsh.FACTVISITID AS V
                         ,TO_DATE(fsh.SITEHITDATE) AS date_ --DW SHOULD I USE PARTITIONDATE INSTEAD?
                         ,MIN(fsh.SITEHITTIME) AS monetatehittime
                         --SHOULD I USE CLIENTHITDATETIME INSTEAD?
                         --DEVICECATEGORYNAME AS device,
                         ,CASE
                           WHEN fsh.DEVICECATEGORYNAME IN ('Tablet','tablet') THEN 'Desktop'
                           WHEN fsh.DEVICECATEGORYNAME IN ('Phone','phone') THEN 'Mobile'
                           ELSE fsh.DEVICECATEGORYNAME
                         END AS device
                         ,CASE
                            WHEN (fsh.NEUSTARSERVERNAME IN ('000','N000N') OR fsh.NEUSTARSERVERNAME IS NULL) AND fsh.NEUSTARCLIENTNAME IS NOT NULL THEN fsh.NEUSTARCLIENTNAME
                            WHEN (fsh.NEUSTARSERVERNAME IN ('000','N000N') OR fsh.NEUSTARSERVERNAME IS NULL) AND fsh.NEUSTARCLIENTNAME IS NULL THEN 'NOMATCH'
                            WHEN LENGTH(fsh.NEUSTARSERVERNAME) = 3 THEN CONCAT('N',fsh.NEUSTARSERVERNAME,'N')
                            ELSE fsh.NEUSTARSERVERNAME
                          END AS NSSEG
                         --SPLIT_PART(CONCAT(EVENTLABELNAME, '&'), '&', 1) AS test --ONLY GET FIRST TEST TO REMOVE LISTENING EVENTS
                         ,SPLIT_PART(CONCAT( (REPLACE(REPLACE(EVENTLABELNAME,'DQ_SP_1_DC-1897400=Experiment&',''),'DQ_SP_2_QQ-1897401=Experiment&','')) , '&'), '&', 1) AS test  --ONLY GET FIRST TEST TO REMOVE LISTENING EVENTS
                         --REPLACE(REPLACE(EVENTLABELNAME,'DQ_SP_1_DC-1897400=Experiment',''),'DQ_SP_2_QQ-1897401=Experiment','')
                     FROM
                         DEAL.PUBLISHED.VW_FACTSITEHIT AS fsh
                         LEFT JOIN factmarketingchannelsummary AS fmc
                            ON fsh.factsitehitid = fmc.factsitehitid
                            AND fsh.partitiondate = fmc.partitiondate
                     WHERE
                         fsh.PARTITIONDATE BETWEEN $startdate AND $enddate
                         --hits.page.pagePath LIKE 'www.progressive.com/'
                         AND fsh.EVENTCATEGORYNAME = 'progCom' --added? should i key on page too?
                         AND fsh.EVENTACTIONNAME = 'Monetate'
                         --AND fsh.EVENTLABELNAME LIKE CONCAT('%',$testnbr,'%')
                         AND fsh.INTERNALIPIND = 0 --DW SHOULD I ADD THIS?
                         AND (fsh.CRAWLERDETECTEDIND IS NULL OR fsh.CRAWLERDETECTEDIND = 0)
                         AND (
                           fsh.useragentstringtext NOT LIKE('%AdsBot-Google%')
                           AND fsh.useragentstringtext NOT LIKE('%APIs-Google%')
                           AND fsh.useragentstringtext NOT LIKE('%Mediapartners-Google%')
                           AND fsh.useragentstringtext NOT LIKE('%AdsBot-Google-Mobile%')
                           AND fsh.useragentstringtext NOT LIKE('%Googlebot%')
                           AND fsh.useragentstringtext NOT LIKE('%AdsBot-Google-Mobile-Apps%')
                           AND fsh.useragentstringtext NOT LIKE('%FeedFetcher-Google%')
                           AND fsh.useragentstringtext NOT LIKE('%Google-Read-Aloud%')
                           AND fsh.useragentstringtext NOT LIKE('%DuplexWeb-Google%')
                           AND fsh.useragentstringtext NOT LIKE('%Google Favicon%')
                           AND fsh.useragentstringtext NOT LIKE('%Google-Read-Aloud%')
                           AND fsh.useragentstringtext NOT LIKE('%googleweblight%')
                           AND fsh.useragentstringtext NOT LIKE('%bot%')
                           AND fsh.useragentstringtext NOT LIKE('%googleweblight%')
                           AND fsh.useragentstringtext NOT LIKE('%ysearch/slurp%')
                           AND fsh.useragentstringtext NOT LIKE('%crawl.yahoo.net%')
                           )
                     GROUP BY
                         fullV,
                         V,
                         date_,
                         --monetatehittime,
                         device,
                         nsseg,
                         test
                   ) AS initial --CHECK IF HOMEPAGE WAS FIRST PAGE IN VISIT
    
                   LEFT JOIN
    
                   (--FIRSTPAGEHOMEPAGE
                   --SET INDICATOR -- 1 IF HOMEPAGE WAS FIRST PAGE IN VISIT
                   SELECT
                       firstpage_fullV,
                       firstpage_V,
                       firstpage_date,
                       CASE
                           WHEN firstpage LIKE '%progressive.com/' THEN 1
                           ELSE 0
                       END AS homepagefirstpage_
                   FROM
                       ( --FIRSTPAGEHOMEPAGE_SUB
                           --GET FIRST PAGE HIT OF VISIT
                           SELECT
                               fsh.VISITORID AS firstpage_fullV
                               ,fmc.FACTVISITID_MKTG_DOW AS firstpage_V
                               --,fsh.FACTVISITID AS firstpage_V
                               ,fsh.SEQUENCEWITHINVISITNBR
                               ,ROW_NUMBER() OVER(PARTITION BY fmc.FACTVISITID_MKTG_DOW ORDER BY fsh.SEQUENCEWITHINVISITNBR) AS PAGEHITNBR
                               ,TO_DATE(fsh.SITEHITDATE) AS firstpage_date --OK TO USE SITEHITDATE HERE? OR DO WE WANT CLIENT
                               ,CASE
                                   WHEN CONTAINS(fsh.VIRTUALPAGENAME, '#') THEN SUBSTR(fsh.VIRTUALPAGENAME,1,CHARINDEX(fsh.VIRTUALPAGENAME, '#') -1) --CLEAN OFF ANYTHING AFTER '#' INCLUDING '#'
                                   ELSE fsh.VIRTUALPAGENAME
                               END AS firstpage
                           FROM
                               DEAL.PUBLISHED.VW_FACTSITEHIT AS fsh
                               LEFT JOIN factmarketingchannelsummary AS fmc
                                 ON fsh.factsitehitid = fmc.factsitehitid
                                 AND fsh.partitiondate = fmc.partitiondate
                           WHERE
                               fsh.PARTITIONDATE BETWEEN $startdate AND $enddate
                               AND fsh.SOURCEBUSINESSAPPLICATIONNAME = 'Progressive.com'
                               AND fsh.HITTYPENAME = 'page'
                           QUALIFY PAGEHITNBR = 1 --GETS THE FIRST PAGE HIT IN A VISIT ONLY
                       ) AS firstpagehomepage_sub
                   ) AS firstpagehomepage
                     ON initial.fullV = firstpagehomepage.firstpage_fullV
                       AND initial.V = firstpagehomepage.firstpage_V
                       AND initial.date_ = firstpagehomepage.firstpage_date

                   LEFT JOIN
    
                   ( --TESTERROR
                   --SET INDICATOR IF VISIT HAS A MONETATE TEST ERROR
                   SELECT
                       fsh.VISITORID AS testerror_fullV
                       ,fmc.FACTVISITID_MKTG_DOW AS testerror_V
                       --,fsh.FACTVISITID AS testerror_V
                       ,TO_DATE(fsh.SITEHITDATE) AS testerror_date
                       ,1 AS testerror
                   FROM DEAL.PUBLISHED.VW_FACTSITEHIT AS fsh
                        LEFT JOIN factmarketingchannelsummary AS fmc
                          ON fsh.factsitehitid = fmc.factsitehitid
                          AND fsh.partitiondate = fmc.partitiondate
                   WHERE
                       fsh.PARTITIONDATE BETWEEN $startdate AND $enddate
                       AND fsh.SOURCEBUSINESSAPPLICATIONNAME = 'Progressive.com' --DW SHOULD I REMOVE THIS OR ONLY WANT THE FIRST PROG COM PAGE HIT?
                       AND (fsh.VIRTUALPAGENAME = 'https://www.progressive.com/' OR fsh.VIRTUALPAGENAME LIKE 'https://www.progressive.com/#%')
                       AND fsh.EVENTACTIONNAME = 'Monetate'
                       AND fsh.EVENTLABELNAME = 'MonetateError'
                   GROUP BY
                       testerror_fullV,
                       testerror_V,
                       testerror_date,
                       testerror
                   ) as testerror 
                     ON initial.fullV = testerror.testerror_fullV
                       AND initial.V = testerror.testerror_V
                       AND initial.date_ = testerror.testerror_date

                   LEFT JOIN

                   ( --VARIANTERROR
                   --FIND IF VISIT HAS MULTIPLE VARIANTS OF SAME TEST
                   SELECT
                       fsh.VISITORID AS varianterror_fullV
                       ,fmc.FACTVISITID_MKTG_DOW AS varianterror_V
                       --,fsh.FACTVISITID AS varianterror_V
                       ,TO_DATE(fsh.SITEHITDATE) AS varianterror_date
                       ,CASE WHEN
                           COUNT(DISTINCT SPLIT_PART(CONCAT(fsh.EVENTLABELNAME, '&'), '&', 1)) > 1 THEN 1
                           ELSE 0
                       END AS multvarianterror_
                   FROM DEAL.PUBLISHED.VW_FACTSITEHIT AS fsh
                        LEFT JOIN factmarketingchannelsummary AS fmc
                          ON fsh.factsitehitid = fmc.factsitehitid
                          AND fsh.partitiondate = fmc.partitiondate
                   WHERE
                       fsh.PARTITIONDATE BETWEEN $startdate AND $enddate
                       AND fsh.SOURCEBUSINESSAPPLICATIONNAME = 'Progressive.com'
                       AND (fsh.VIRTUALPAGENAME = 'https://www.progressive.com/' OR fsh.VIRTUALPAGENAME LIKE 'https://www.progressive.com/#%')
                       AND fsh.EVENTACTIONNAME = 'Monetate'
                       --AND fsh.EVENTLABELNAME LIKE CONCAT('%',$testnbr,'%')
                   GROUP BY
                       varianterror_fullV,
                       varianterror_V,
                       varianterror_date
                    ) AS varianterror
                      ON initial.fullV = varianterror.varianterror_fullV
                        AND initial.V = varianterror.varianterror_V
                        AND initial.date_ = varianterror.varianterror_date

                    LEFT JOIN
  
                    (--NEXTPAGELOGIN
                      --SET INDICATOR -- 1 IF LOGIN WAS SECOND PAGE IN VISIT
                      SELECT
                          nextpagelogin_fullV,
                          nextpagelogin_V,
                          nextpagelogin_date,
                          CASE
                              WHEN (LOWER(secondpage) LIKE '%page=customersummary.main%' OR LOWER(secondpage) LIKE '%page=customersummary.main%' OR LOWER(secondpage) LIKE '%account.apps.progressive.com/access/login%') THEN 1
                              --virtualpagename = '/access/login'
                              ELSE 0
                          END AS loginsecondpage_
                      FROM
                          ( --NEXTPAGELOGIN_SUB
                              --GET SECOND PAGE HIT OF VISIT (WITHIN SOURCEBUSINESSAPPLICATIONNAME = Progressive.com)
                              SELECT
                                  fsh.VISITORID AS nextpagelogin_fullV
                                  ,fmc.FACTVISITID_MKTG_DOW AS nextpagelogin_V
                                  --,fsh.FACTVISITID AS nextpagelogin_V
                                  ,fsh.SEQUENCEWITHINVISITNBR
                                  ,ROW_NUMBER() OVER(PARTITION BY fmc.FACTVISITID_MKTG_DOW ORDER BY fsh.SEQUENCEWITHINVISITNBR) AS PAGEHITNBR
                                  ,TO_DATE(fsh.SITEHITDATE) AS nextpagelogin_date --OK TO USE SITEHITDATE HERE? OR DO WE WANT CLIENT
                                  ,fsh.PAGEURLADDRESS AS secondpage
                              FROM
                                  DEAL.PUBLISHED.VW_FACTSITEHIT AS fsh
                                  LEFT JOIN factmarketingchannelsummary AS fmc
                                    ON fsh.factsitehitid = fmc.factsitehitid
                                    AND fsh.partitiondate = fmc.partitiondate
                              WHERE
                                  fsh.PARTITIONDATE BETWEEN $startdate AND $enddate
                                  AND fsh.SOURCEBUSINESSAPPLICATIONNAME IN ('Progressive.com','Online Servicing Web Portal') --have to include servicing to pick up the login page
                                  AND fsh.HITTYPENAME = 'page'
                              QUALIFY PAGEHITNBR = 2 --GETS THE SECOND PAGE HIT IN A VISIT ONLY
                          ) AS nextpagelogin_sub
                    ) AS nextpagelogin
                      ON initial.fullV = nextpagelogin.nextpagelogin_fullV
                        AND initial.V = nextpagelogin.nextpagelogin_V
                        AND initial.date_ = nextpagelogin.nextpagelogin_date

                    LEFT JOIN
                    ( --returnvisitor
                      SELECT
                        pretest_return_fullV
                        ,CASE
                          WHEN (homepage_visit_beforetest = 1 AND otherpage_visit_beforetest = 1) THEN 'return_pretest_homeandotherpage'
                          WHEN homepage_visit_beforetest = 1 THEN 'return_pretest_homepage'
                          WHEN otherpage_visit_beforetest = 1 THEN 'return_pretest_otherpage'
                        END AS returnvisitor_pretest_
                      FROM
                
                    ( --returninitial
                      --set indicators if user saw homepage before test
                        SELECT
                          pretest_return_fullV
                          ,MAX(homepage) AS homepage_visit_beforetest
                          ,MAX(otherpage) AS otherpage_visit_beforetest
                        FROM
                        ( --returninitial_
                          SELECT
                            VISITORID AS pretest_return_fullV
                            ,CASE
                              WHEN (VIRTUALPAGENAME = 'https://www.progressive.com/' OR VIRTUALPAGENAME LIKE 'https://www.progressive.com/#%' OR VIRTUALPAGENAME LIKE 'https://www.progressive.com/?%') THEN 1
                              ELSE 0
                            END AS homepage
                            ,CASE
                              WHEN (VIRTUALPAGENAME LIKE 'https://www.progressive.com/%' AND (VIRTUALPAGENAME NOT LIKE 'https://www.progressive.com/#%' AND VIRTUALPAGENAME NOT LIKE 'https://www.progressive.com/?%')) THEN 1
                              ELSE 0
                            END AS otherpage,
                          FROM DEAL.PUBLISHED.VW_FACTSITEHIT
                          WHERE
                            PARTITIONDATE BETWEEN $pre_startdate AND $pre_startdate2 --90 DAYS BEFORE TEST?
                            AND SOURCEBUSINESSAPPLICATIONNAME = 'Progressive.com' --include any others? --'DQ' 'UQ' 'HQX'
                            AND HITTYPENAME = 'page'
                          GROUP BY
                            pretest_return_fullV
                            ,homepage
                            ,otherpage
                        ) AS returninitial_
                        GROUP BY
                          pretest_return_fullV
                    ) AS returninitial
                     GROUP BY
                       pretest_return_fullV
                       ,homepage_visit_beforetest
                       ,otherpage_visit_beforetest
                    ) AS returnvisitor
                      ON initial.fullV = returnvisitor.pretest_return_fullV

                    LEFT JOIN

                    (
                      --ALL EVENTS
                      SELECT
                        fsh.VISITORID AS event_fullV
                        ,fmc.FACTVISITID_MKTG_DOW AS event_V
                        --,fsh.FACTVISITID AS event_V
                        ,TO_DATE(fsh.SITEHITDATE) AS event_date
                        ,fsh.SITEHITTIME AS event_time
                        ,fsh.EVENTCATEGORYNAME as event_category
                        ,fsh.EVENTACTIONNAME as event_action
                        ,fsh.EVENTLABELNAME as event_label
                        --get virtualpagename here?
                        --APPLICATIONSOURCESESSIONID, --in factquotesummary, doesnt come through on qs events
                        --QUOTEACTIVITYID, --in factquotesummary, doesnt come through on qs events
                        --handshakeguid --COMES THORUGH ON QuoteStart, QuoteStart-ApiCall, BoltRetrieve-Attempt-{email, etc} --do not get it on QuoteRetrieve
                      FROM
                        DEAL.PUBLISHED.VW_FACTSITEHIT AS fsh
                          LEFT JOIN factmarketingchannelsummary AS fmc
                            ON fsh.factsitehitid = fmc.factsitehitid
                            AND fsh.partitiondate = fmc.partitiondate
                      WHERE
                        fsh.PARTITIONDATE BETWEEN $startdate AND $enddate
                        AND fsh.SOURCEBUSINESSAPPLICATIONNAME = 'Progressive.com'
                        AND fsh.HITTYPENAME = 'event'
                        AND fsh.EVENTCATEGORYNAME = 'progCom'
                        --AND (fsh.VIRTUALPAGENAME = 'https://www.progressive.com/' OR fsh.VIRTUALPAGENAME LIKE 'https://www.progressive.com/#%' OR fsh.VIRTUALPAGENAME = 'https://www.progressive.com/home-retrieve/' )
                        AND fsh.VIRTUALPAGENAME LIKE 'https://www.progressive.com/%'
                        --Also need to include https://www.progressive.com/home-retrieve/ ???
                        --action='QuoteRetrieve' label='QuoteNumber-Homesite' -- for Bolt /home-retrieve, no product type passed
                        AND fsh.EVENTACTIONNAME IN ('LinkClick', 'ButtonClick','QuoteStart','QuoteStart-ApiCall','QuoteRetrieve','QuoteRetrieve-Success')
                        --,'BoltRetrieve-Attempt-email','BoltRetrieve-Attempt-quote','BoltRetrieve-Attempt-quotenumber','BoltRetrieve-Success-email','BoltRetrieve-Success-quote','BoltRetrieve-Success-quotenumber')
                      --Don't see any reason to group if we just want all events
                      ORDER BY
                        event_fullV
                        ,event_V
                        ,event_date
                        ,event_time
                    ) AS allevents
                      ON initial.fullV = allevents.event_fullV
                        AND initial.V = allevents.event_V
                        AND initial.date_ = allevents.event_date

              ) AS main
  
            GROUP BY
              fullV
              ,V
              ,date_
              ,monetatehittime
              ,device
              ,nsseg
              ,homepagefirstpage
              ,test
              ,monetatetesterror
              ,multvarianterror
              ,loginsecondpage
              --,returnvisit_posttest
              ,returnvisitor_pretest            
          ) as maxevents
  
        GROUP BY
          fullV,
          V,
          date_,
          -- monetatehittime,
          device,
          nsseg,
          homepagefirstpage,
          test,
          monetatetesterror,
          multvarianterror,
          -- returnvisit_posttest,
          returnvisitor_pretest,
          cnt,
          QS_,
          QR_,
          AUQS_LUP,
          AUQR_LUP,
          AUCOQS_LUP,
          AUHOQS_LUP,
          AURTQS_LUP,
          BTQS_LUP,
          BTQR_LUP,
          CQS_LUP,
          CAQS_LUP,
          CAQR_LUP,
          CCQS_LUP,
          DEQS_LUP,
          EDQS_LUP,
          HQS_LUP,
          BoltQR_LUP,
          HomesiteQR_LUP,
          HEQS_LUP,
          HSQS_LUP,
          HWQS_LUP,
          IDQS_LUP,
          IDCQS_LUP,
          IDCCQS_LUP,
          IDEQS_LUP,
          IDECQS_LUP,
          LQS_LUP,
          LFQS_LUP,
          LPQS_LUP,
          LUQS_LUP,
          LWQS_LUP,
          MXQS_LUP,
          MCQS_LUP,
          MCQR_LUP,
          MEQS_LUP,
          MHQS_LUP,
          PQS_LUP,
          PRQS_LUP,
          RQS_LUP,
          ASIQR_LUP,
          RVQS_LUP,
          MTQR_LUP,
          TTQR_LUP,
          SHQS_LUP,
          SMQS_LUP,
          SMQR_LUP,
          SWQS_LUP,
          TCQS_LUP, --not on BQ version
          TRQS_LUP,
          UMQS_LUP,
          VIQS_LUP,
          WEQS_LUP,
          LOGIN_LUP,
          FAA_LUP
      ) AS LUPcalc --LUPcal on BQ version
    
    WHERE
      monetatetesterror = 0
      --AND device = 'Desktop'
      -- AND multivarianterror = 0
  ) AS CreateLUP --LUPcreate in BQ version
  
    GROUP BY
      date_
      ,device
      ,nsseg
      ,partnercode
      ,returnvisitor
      ,test
    ORDER BY
      date_
      ,test
      ,device
      ,returnvisitor
      ,nsseg
