SELECT
co.created_dt,
CASE WHEN apps.app_id IS NULL AND sess_cobrand IN 7 THEN 'FSoM'  
WHEN apps.app_id IS  NULL THEN 'Core Site on PC'
WHEN TRIM(apps.prdct_name) IN 'IPhoneApp' THEN 'iPhone App'
WHEN TRIM(apps.prdct_name) IN ('Android','Android Motors') THEN 'Android App'
WHEN TRIM(apps.prdct_name) IN 'IPad' THEN 'iPad App'
WHEN TRIM(apps.prdct_name) IN ('MobWeb','MobWebGXO') THEN 'Mobile Web'
ELSE 'Other'
END Platform,  

CASE WHEN buyer_country_id IN  (1, -1, 0, -999, 225, 679, 1000) THEN 'US'  
WHEN buyer_country_id IN 3 THEN 'UK'
WHEN buyer_country_id IN 77 THEN 'DE'
WHEN buyer_country_id IN 15 THEN 'AU'
WHEN buyer_country_id IN 2 THEN 'CA'
ELSE 'Other'
END buyer_country,  

SUM(CAST(co.item_price * co.quantity * CAST(cr.CURNCY_PLAN_RATE AS FLOAT) AS DECIMAL(18,2))) AS gmb_plan   

FROM  
(
  select 
  created_dt,
  sess_cobrand,
  buyer_id,
  quantity,
  item_price,
  lstg_curncy_id,
  leaf_categ_id,
  app_id,
  item_site_id,
  buyer_country_id
  
  from p_soj_cl_v.checkout_metric_item
  
  where
  created_dt BETWEEN current_date-185 AND current_date-2
  AND auct_end_dt >= current_date-185
  AND ck_wacko_yn = 'N'
  AND auct_type_code NOT IN (12,15)   
) co 

INNER JOIN access_views.ssa_curncy_plan_rate_dim cr ON (co.lstg_curncy_id = cr.curncy_id)
INNER JOIN access_views.dw_category_groupings cat ON (co.leaf_categ_id = cat.leaf_categ_id AND co.item_site_id = cat.site_id)
LEFT JOIN access_views.dw_api_mbl_app apps ON (co.app_id = apps.app_id)

WHERE  
cat.sap_category_id NOT IN (5,7,23,41)

GROUP BY  
1,2,3;
